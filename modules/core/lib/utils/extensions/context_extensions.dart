import 'package:flutter/widgets.dart' show BuildContext;
import 'package:go_router/go_router.dart';

extension RouterExtension on BuildContext {
  GoRouter get router => GoRouter.of(this);
}