import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usacase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(InitialState()) {
    on<OnLoginEvent>(_onLoginEvent);
  }

  _onLoginEvent(OnLoginEvent event, Emitter<AuthState> emitter) async {
    emitter(LoadingAuthState());

    final result = await loginUseCase.invoke(
      {
        "email": event.email,
        "password": event.password,
      },
    );
    result.fold((l) {
      emitter(ErrorAuthState(l.errorMessage));
    }, (r) {
      emitter(SuccessAuthState(r));
    });
  }
}
