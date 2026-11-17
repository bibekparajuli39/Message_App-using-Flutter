import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:message_app/core/routes/routes.dart';
import 'package:message_app/features/auth/screens/login_screen.dart';
import 'package:message_app/features/auth/screens/signup_screen.dart';
import 'package:message_app/features/home/screens/home_screen.dart';

class AppRoutes {
  // The route configuration
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: Routes.login,
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: Routes.signup,
            builder: (BuildContext context, GoRouterState state) {
              return SignupScreen();
            },
          ),
          GoRoute(
            path: Routes.home,
            builder: (BuildContext context, GoRouterState state) {
              return HomeScreen();
            },
          ),
        ],
      ),
    ],
  );
}
