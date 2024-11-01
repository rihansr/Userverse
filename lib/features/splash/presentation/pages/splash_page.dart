import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/styles/dimens.dart';
import '../../../../core/styles/drawables.dart';
import '../../../../core/shared/data/data_sources/shared_prefs.dart';
import '../../../../core/utils/injections.dart';
import '../../../../core/shared/presentation/widgets/backdrop_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(kSplashTimeout, _navigateTo);
    super.initState();
  }

  _navigateTo() => context.pushReplacementNamed(
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
              fit: BoxFit.contain,
            ),
            LottieBuilder.asset(
              drawable.loading,
              height: 72,
              width: 72,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
