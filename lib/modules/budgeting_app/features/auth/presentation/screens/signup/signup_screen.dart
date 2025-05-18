import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lifesphere_essentials/core/common/back_button.dart';
import 'package:lifesphere_essentials/core/common/widgets/elevated_button.dart';
import 'package:lifesphere_essentials/core/common/widgets/text.dart';
import 'package:lifesphere_essentials/core/common/widgets/text_form_field.dart';
import 'package:lifesphere_essentials/core/constants/colors.dart';
import 'package:lifesphere_essentials/core/constants/route_names.dart';
import 'package:lifesphere_essentials/core/constants/strings.dart';
import 'package:lifesphere_essentials/core/utils/snackbar.dart';
import 'package:lifesphere_essentials/injection/injection.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/blocs/auth_bloc.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/blocs/auth_event.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/blocs/auth_state.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/dto/signup_dto.dart';
import 'package:lifesphere_essentials/service/hive_service/hive_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _userHiveService = getIt<HiveService>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void checkUserExist() {
    context.read<AuthBloc>().add(
      CheckUserExistEvent(email: _emailController.text.trim()),
    );
  }

  void signUp() {
    context.read<AuthBloc>().add(
      SignUpEvent(
        signUpParams: SignUpParams(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              backButton(
                context,
                onPressed: () {
                  context.pop();
                },
              ),
              const SizedBox(height: 30),
              textWidget(
                text: AppStrings.welcome,
                fontSize: 40,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 30),
              textWidget(
                text: AppStrings.email,
                fontSize: 16,
                color: ColorCodes.lightGreen,
              ),
              const SizedBox(height: 6),
              textFormField(
                hintText: AppStrings.yourEmail,
                controller: _emailController,
                textInputType: TextInputType.emailAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[a-zA-Z0-9@.]+$'),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              textWidget(
                text: AppStrings.password,
                fontSize: 16,
                color: ColorCodes.lightGreen,
              ),
              const SizedBox(height: 6),
              textFormField(
                hintText: AppStrings.yourPassword,
                controller: _passwordController,
                textInputType: TextInputType.visiblePassword,
                inputFormatters: [],
              ),
              const SizedBox(height: 18),
              textWidget(
                text: AppStrings.confirmPassword,
                fontSize: 16,
                color: ColorCodes.lightGreen,
              ),
              const SizedBox(height: 6),
              textFormField(
                hintText: AppStrings.oneMoreTime,
                controller: _confirmPasswordController,
                textInputType: TextInputType.visiblePassword,
                inputFormatters: [],
              ),
              const SizedBox(height: 24),
              Center(
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      showSnackBar(
                        context,
                        message: state.message,
                        isError: true,
                      );
                    } else if (state is SignUpFinishedState) {
                      showSnackBar(context, message: "Successfully signed up");
                      _userHiveService
                          .addUser(
                            uid: state.user.uid,
                            email: _emailController.text.trim(),
                          )
                          .whenComplete(() {
                            context.pushReplacement(
                              RouteNames.categoriesScreen,
                            );
                          });
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CupertinoActivityIndicator(
                        radius: 20,
                        color: ColorCodes.splashBackground,
                      );
                    }
                    return elevatedButton(
                      width: 190,
                      height: 45,
                      onPressed: () async {
                        if (_emailController.text.isEmpty) {
                          showSnackBar(
                            context,
                            message: AppStrings.invalidEmail,
                            isError: true,
                          );
                        } else if (_passwordController.text.isEmpty) {
                          showSnackBar(
                            context,
                            message: AppStrings.emptyPassword,
                            isError: true,
                          );
                        } else if (_confirmPasswordController.text.isEmpty) {
                          showSnackBar(
                            context,
                            message: AppStrings.emptyPassword,
                            isError: true,
                          );
                        } else if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          showSnackBar(
                            context,
                            message: AppStrings.passwordMismatch,
                            isError: true,
                          );
                        } else {
                          signUp();
                        }
                      },
                      textWidget: textWidget(
                        text: AppStrings.signUp,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: ColorCodes.appBackground,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
