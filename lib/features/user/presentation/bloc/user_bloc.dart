import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../user/domain/models/user_model.dart';
import '../../domain/usecases/single_user_usecase.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SingleUserUseCase userUseCase;
  UserModel user = UserModel();

  UserBloc({required this.userUseCase}) : super(LoadingRetrieveUserState()) {
    on<OnRetrieveUserEvent>(_onFetchUsersEvent);
  }

  _onFetchUsersEvent(
      OnRetrieveUserEvent event, Emitter<UserState> emitter) async {
    final result = await userUseCase.invoke(event.id);
    result.fold((l) {
      emitter(ErrorRetrieveUserState(l.errorMessage));
    }, (r) {
      user = r;
      emitter(SuccessRetrieveUserState());
    });
  }
}
