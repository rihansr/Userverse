import 'package:flutter/material.dart';
import 'core/config/app_config.dart';
import 'core/routing/routing.dart';
import 'core/service/navigation_service.dart';

Future<void> main() async =>
    await appConfig.init().then((_) => runApp(const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Userverse',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: navigator.scaffoldMessengerKey,
      routerConfig: routing,
    );
  }
}
