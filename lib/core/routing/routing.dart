import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/user/presentation/pages/user_details_page.dart';
import '../service/navigation_service.dart';
import 'routes.dart';

final GoRouter routing = GoRouter(
  navigatorKey: navigator.navigatorKey,
  initialLocation: Routes.splash,
  routes: <RouteBase>[
    GoRoute(
      name: Routes.splash,
      path: Routes.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      name: Routes.login,
      path: Routes.login,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      name: Routes.landing,
      path: Routes.landing,
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardPage();
      },
    ),
    GoRoute(
      name: Routes.user,
      path: '${Routes.user}/:id',
      builder: (BuildContext context, GoRouterState state) {
        return const UserDetailsPage();
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
