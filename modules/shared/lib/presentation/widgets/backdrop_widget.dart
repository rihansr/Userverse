import 'package:core/styles/drawable.dart';
import 'package:flutter/material.dart';

class Backdrop extends StatelessWidget {
  final Widget child;
  const Backdrop({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(drawable.blurryBackdrop),
          fit: BoxFit.fill,
        ),
      ),
      child: child,
    );
  }
}
