import 'package:shared/presentation/bloc/bloc.dart';
import 'package:user/user.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final UsersUseCase usersUseCase;
  List<UserModel> users = [];

  DashboardBloc({required this.usersUseCase})
      : super(LoadingFetchUsersState()) {
    on<OnFetchUsersEvent>(_onFetchUsersEvent);
  }

  _onFetchUsersEvent(
      OnFetchUsersEvent event, Emitter<DashboardState> emitter) async {
    final result = await usersUseCase.invoke();
    result.fold((l) {
      emitter(ErrorFetchUsersState(l.errorMessage));
    }, (r) {
      users = r;
      emitter(r.isEmpty ? EmptyUsersState() : SuccessFetchUsersState());
    });
  }
}
