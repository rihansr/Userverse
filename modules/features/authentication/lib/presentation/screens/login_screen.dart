import 'package:core/router/routes.dart';
import 'package:shared/presentation/bloc/bloc.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import 'package:core/styles/styles.dart';
import 'package:core/utils/enums.dart';
import 'package:core/utils/extensions/context_extensions.dart';
import 'package:core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:shared/di/service_locator.dart';
import '../../domain/usecases/login_usacase.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthBloc _bloc = AuthBloc(loginUseCase: sl<LoginUseCase>());

  bool _enabledAutoValidate = false;

  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Backdrop(
        child: SafeArea(
          child: CardBox(
            children: [
              SvgPicture.asset(
                drawable.splashLogo,
                width: dimen.width / 2.5,
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(height: 24),
              Text(
                string.of(context).login,
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                string.of(context).enterYourDetails,
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFieldWidget(
                      controller: _emailController,
                      autoValidate: _enabledAutoValidate,
                      validator: (value) => validator.validateEmail(value),
                      hintText: string.of(context).emailHint,
                      title: string.of(context).email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFieldWidget(
                      controller: _passwordController,
                      autoValidate: _enabledAutoValidate,
                      validator: (value) => validator.validatePassword(
                        value,
                        field: string.of(context).password,
                      ),
                      hintText: string.of(context).passwordHint,
                      title: string.of(context).password,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    BlocConsumer<AuthBloc, AuthState>(
                      bloc: _bloc,
                      listener: (context, state) {
                        if (state is ErrorAuthState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            style.snackbar(state.errorMsg,
                                type: AlertType.error),
                          );
                        } else if (state is SuccessAuthState) {
                          context.router.pushReplacementNamed(Routes.landing);
                        }
                      },
                      builder: (context, state) {
                        return Button(
                          label: string.of(context).signIn,
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _bloc.add(
                                OnLoginEvent(
                                  validator.string(_emailController)!,
                                  validator.string(_passwordController)!,
                                ),
                              );
                            } else {
                              setState(() => _enabledAutoValidate = true);
                            }
                          },
                          loading: state is LoadingAuthState,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
