import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:petuco/presentation/pages/pet_info_page.dart';
import 'package:petuco/presentation/widgets/background_widget.dart';
import 'package:petuco/presentation/widgets/footer_widget.dart';

class NfcConectionView extends StatefulWidget {
  const NfcConectionView({super.key});

  @override
  State<NfcConectionView> createState() => _NfcConectionViewState();
}

class _NfcConectionViewState extends State<NfcConectionView> {
  bool isNfcConnected = false; // Track the NFC connection state
  bool isWritingInProgress = false; // Track if NFC writing is in progress
  String _nfcData = ''; // Display any data related to NFC

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          const BackGround(title: "NFC connection"),
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            right: 0,
            child: Text(
              "Save your pet’s data in\nits NFC",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.5),
                fontFamily: const String.fromEnvironment("Inter"),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.45,
            left: (screenWidth - screenWidth * 0.8) / 2,
            child: Image.asset(
              'assets/images/nfcConection.png',
              width: screenWidth * 0.8,
              height: screenHeight * 0.3,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.40,
            left: 0,
            right: 0,
            child: const Text(
              "Current connection",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: String.fromEnvironment("Inter"),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.28,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.07),
              decoration: BoxDecoration(
                color: isNfcConnected
                    ? Colors.green.withOpacity(0.7)
                    : Colors.white.withOpacity(0.53),
                borderRadius: BorderRadius.circular(40),
                border: isNfcConnected
                    ? Border.all(
                        color: Colors.green,
                        width: 2,
                      )
                    : null,
              ),
              child: Text(
                isNfcConnected ? "NFC Connected" : "No NFC connection",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  color: isNfcConnected ? Colors.white : const Color(0xFF4B8CAF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.15,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: Opacity(
              opacity: 0.9,
              child: ElevatedButton(
                onPressed: !isWritingInProgress && !isNfcConnected
                    ? () {
                        _startNfcSession();
                      }
                    : null, // Disable if NFC is connected or writing is in progress
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF65D389),
                  side: const BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.12, vertical: screenHeight * 0.03),
                ),
                child: Text(
                  isWritingInProgress ? 'Writing...' : 'Look for a NFC',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FooterWidget(),
          ),
        ],
      ),
    );
  }

void _startNfcSession() async {
  setState(() {
    isWritingInProgress = true;
  });

  await NfcManager.instance.startSession(
    onDiscovered: (NfcTag tag) async {
      final ndef = Ndef.from(tag);

      if (ndef != null) {
        try {
          if (isWritingInProgress) {
            //This will be get from the pet info view when we have the button
            String petId = "1"; // this is temporal!!!!

            // Write in the NFC tag
            NdefMessage message = NdefMessage([NdefRecord.createText(petId)]);
            await ndef.write(message);  
            print("Data written to NFC: $petId");
            setState(() {
              isWritingInProgress = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data written to NFC')));

          } else {
            // Read from the NFC tag
            NdefMessage message = await ndef.read();  
            String nfcData = message.records.first.payload.toString();  

            // get id from payload
            String petIdString = nfcData.trim(); 
            int petId = int.parse(petIdString);
            setState(() {
              isNfcConnected = true;
              isWritingInProgress = false;
            });

            //go to the page
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PetInfoPage(petId: petId), 
              ),
            );
          }

        } catch (e) {
          print("Error reading or writing NFC data: $e");
          setState(() {
            _nfcData = 'Error processing NFC data';
            isWritingInProgress = false;
          });
        }
      } else {
        setState(() {
          _nfcData = 'NDEF not supported';
          isWritingInProgress = false; 
        });
      }
    },
  );
}
}