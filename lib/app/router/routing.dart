import 'package:authentication/presentation/screens/login_screen.dart';
import 'package:core/router/routes.dart';
import 'package:core/service/navigation_service.dart';
import 'package:dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:splash/splash.dart';
import 'package:user/presentation/screens/user_details_screen.dart';

final GoRouter routing = GoRouter(
  navigatorKey: navigator.navigatorKey,
  initialLocation: Routes.splash,
  routes: <RouteBase>[
    GoRoute(
      name: Routes.splash,
      path: Routes.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      name: Routes.login,
      path: Routes.login,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      name: Routes.landing,
      path: Routes.landing,
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardScreen();
      },
    ),
    GoRoute(
      name: Routes.user,
      path: '${Routes.user}/:id',
      builder: (BuildContext context, GoRouterState state) {
        return UserDetailsScreen(id: int.parse(state.pathParameters['id']!));
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(),
    body: const Center(
      child: Text('Page not found'),
    ),
  ),
);
