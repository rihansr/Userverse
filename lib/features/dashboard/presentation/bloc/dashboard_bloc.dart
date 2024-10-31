import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../user/domain/models/user_model.dart';
import '../../../user/domain/usecases/users_usacase.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<AuthEvent, DashboardState> {
  final UsersUseCase usersUseCase;
  List<UserModel> users = [];

  DashboardBloc({required this.usersUseCase}) : super(LoadingFetchUsersState()) {
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
