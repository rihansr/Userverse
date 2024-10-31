import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/shared/presentation/widgets/listview_builder_widget.dart';
import '../../../../../core/styles/drawables.dart';
import '../../../../../core/utils/injections.dart';
import '../../../../user/domain/usecases/users_usacase.dart';
import '../../bloc/dashboard_bloc.dart';
import '../../components/user_item.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  final DashboardBloc _bloc = DashboardBloc(usersUseCase: sl<UsersUseCase>());

  @override
  void initState() {
    _bloc.add(OnFetchUsersEvent());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is ErrorFetchUsersState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is EmptyUsersState || state is ErrorFetchUsersState) {
          return Center(
            child: Transform.scale(
              scale: 1.3,
              child: LottieBuilder.asset(drawable.empty),
            ),
          );
        } else {
          return ListViewBuilder(
            items: _bloc.users,
            skeletonItems: List.filled(6, null),
            loading: state is LoadingFetchUsersState,
            itemBuilder: (i, user) => UserItem(
              key: ValueKey(user?.id ?? i),
              user: user,
            ),
          );
        }
      },
    );
  }
}
