import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/shared/constants.dart';
import '../../../../core/shared/dimens.dart';
import '../../../../core/shared/drawables.dart';
import '../../../../core/widget/backdrop_widget.dart';

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

  _navigateTo() => context.pushReplacementNamed(Routes.login);

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
