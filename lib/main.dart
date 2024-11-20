import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:settings/settings.dart';
import 'package:shared/di/service_locator.dart';
import 'app/di/inject.dart';
import 'app/router/routing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Core.instance.init();
  await Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
    configureDependencies(),
  ]);
  await sl.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sl<Settings>().settings,
      builder: (_, settings, __) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: settings.themeMode == ThemeMode.light
                ? Brightness.dark
                : Brightness.light,
          ),
        );
        return MaterialApp.router(
          title: 'Userverse',
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: navigator.scaffoldMessengerKey,
          themeMode: settings.themeMode,
          theme: theming(ThemeMode.light),
          darkTheme: theming(ThemeMode.dark),
          locale: settings.language.locale,
          localizationsDelegates: string.delegates,
          supportedLocales: string.supportedLocales,
          routerConfig: routing,
        );
      },
    );
  }
}
