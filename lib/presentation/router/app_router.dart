import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:petuco/presentation/pages/home_page.dart';
import 'package:petuco/presentation/pages/pet_info_page.dart';
import 'package:petuco/presentation/pages/pet_medical_historial_page.dart';


final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/${HomeUserPage.route}',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeUserPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '${PetInfoPage.route}/:petId',
          builder: (BuildContext context, GoRouterState state) {
            final petId = int.parse(state.params['petId']!);
            return PetInfoPage(petId: petId);
          },
          routes: <RouteBase>[
            GoRoute(
              path: PetMedicalHistorialPage.route,
              builder: (BuildContext context, GoRouterState state) {
                final petId = int.parse(state.params['petId']!);
                return PetMedicalHistorialPage(petId: petId);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);