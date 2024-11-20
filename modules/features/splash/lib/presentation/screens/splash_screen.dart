import 'dart:async';
import 'package:core/router/routes.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import 'package:core/styles/styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared/data/data_sources/local/shared_prefs.dart';
import 'package:shared/di/service_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(kSplashTimeout, _navigateTo);
    super.initState();
  }

  _navigateTo() => context.router.pushReplacementNamed(
        sl<SharedPrefs>().isLoggedIn ? Routes.landing : Routes.login,
      );

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: Backdrop(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 32),
            SvgPicture.asset(
              drawable.splashLogo,
              width: dimen.width / 1.5,
            ),
            LottieBuilder.asset(
              drawable.loading,
              width: 72,
              height: 72,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
