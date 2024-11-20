import 'package:core/router/routes.dart';
import 'package:core/styles/styles.dart';
import 'package:core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/domain/models/user_model.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.user,
    required this.tag,
  });

  final UserModel? user;
  final String tag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: user == null
          ? null
          : () {
              HapticFeedback.lightImpact();
              context.router.pushNamed(
                Routes.user,
                pathParameters: {'id': user!.id.toString()},
                extra: user,
              );
            },
      child: Hero(
        tag: tag,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            horizontalTitleGap: 12,
            leading: style.avatar(user?.name ?? ''),
            title: Text(
              user?.name ?? string.of(context).anonymous,
              maxLines: 1,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  user?.email ?? 'N/A',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.hintColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.company?.toString() ?? 'N/A',
                  maxLines: 1,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
