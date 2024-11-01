import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/shared/presentation/widgets/backdrop_widget.dart';
import '../../../../core/styles/strings.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/utils/injections.dart';
import '../../domain/usecases/single_user_usecase.dart';
import '../bloc/user_bloc.dart';

class UserDetailsPage extends StatefulWidget {
  final int id;
  const UserDetailsPage({super.key, required this.id});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final UserBloc _bloc = UserBloc(userUseCase: sl<SingleUserUseCase>());

  @override
  void initState() {
    _bloc.add(OnRetrieveUserEvent(widget.id));
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: Text(string.of(context).userDetails),
      ),
      body: Backdrop(
        child: SafeArea(
          child: BlocConsumer<UserBloc, UserState>(
            bloc: _bloc,
            listener: (context, state) {},
            builder: (context, state) {
              return Skeletonizer(
                enabled: state is LoadingRetrieveUserState,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Hero(
                      tag: 'user-${_bloc.user.id}',
                      child: CupertinoFormSection.insetGrouped(
                        backgroundColor: Colors.transparent,
                        decoration: style.defaultDecoration(context),
                        children: [
                          ListTile(
                            leading: style.avatar(_bloc.user.name ?? ''),
                            title: Text(
                              _bloc.user.name ?? string.of(context).anonymous,
                            ),
                            subtitle: Text(
                              _bloc.user.username ?? 'N/A',
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.email,
                              color: theme.primaryColor,
                            ),
                            title: Text(
                              _bloc.user.email ?? 'N/A',
                            ),
                            titleTextStyle: theme.textTheme.labelLarge,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: theme.primaryColor,
                            ),
                            title: Text(
                              _bloc.user.phone ?? 'N/A',
                            ),
                            titleTextStyle: theme.textTheme.labelLarge,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.web,
                              color: theme.primaryColor,
                            ),
                            title: Text(
                              _bloc.user.website ?? 'N/A',
                            ),
                            titleTextStyle: theme.textTheme.labelLarge,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: theme.primaryColor,
                            ),
                            title: Text(
                              _bloc.user.address?.toString() ?? 'N/A',
                            ),
                            titleTextStyle: theme.textTheme.labelLarge,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.business,
                              color: theme.primaryColor,
                            ),
                            title: Text(
                              _bloc.user.company?.toString() ?? 'N/A',
                            ),
                            titleTextStyle: theme.textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
