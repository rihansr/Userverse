import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/enums.dart';
import '../utils/extensions/string_extensions.dart';
import '../service/navigation_service.dart';
import 'colour.dart';
import 'strings.dart';

final style = _Style.value;

class _Style {
  static _Style get value => _Style._();
  _Style._();

  final defaultBlur = ImageFilter.blur(sigmaX: 4, sigmaY: 4);

  BoxDecoration defaultDecoration(BuildContext context) => BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
      );

  Widget avatar(String label) {
    final theme = Theme.of(navigator.context);
    return CircleAvatar(
      backgroundColor: theme.colorScheme.primary,
      child: Text(
        label.first,
        style: theme.textTheme.titleLarge?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }

  SnackBar snackbar(
    String message, {
    AlertType? type,
    String? actionLabel,
    int duration = 3,
    Function()? onAction,
  }) =>
      SnackBar(
        backgroundColor: type?.backgroundColor,
        content: Text(
          message,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(navigator.context)
              .snackBarTheme
              .contentTextStyle!
              .copyWith(
                color: type?.textColor,
              ),
        ),
        action: (onAction != null)
            ? SnackBarAction(
                label: actionLabel ?? type?.actionLabel ?? string.of(navigator.context).okay,
                textColor: type?.textColor,
                onPressed: onAction,
              )
            : null,
        duration: Duration(seconds: duration),
      );
}

extension _MessageTypeExtensions on AlertType {
  String get actionLabel {
    switch (this) {
      case AlertType.error:
        return string.of(navigator.context).cancel;
      default:
        return string.of(navigator.context).okay;
    }
  }

  Color? get backgroundColor => (() {
        final theme = Theme.of(navigator.context);
        switch (this) {
          case AlertType.error:
            return theme.colorScheme.error;
          case AlertType.info:
          default:
            return theme.colorScheme.primary;
        }
      }());

  Color? get textColor => (() {
        switch (this) {
          default:
            return ColorPalette.dark().headline;
        }
      }());
}
