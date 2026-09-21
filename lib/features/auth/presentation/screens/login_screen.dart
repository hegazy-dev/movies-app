import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:movies/core/constants/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_styles.dart';

import 'package:movies/features/auth/data/data_sources/auth_data_source.dart';
import 'package:movies/features/auth/data/repositories/auth_repository.dart';
import 'package:movies/features/auth/presentation/cubit/login_cubit.dart';
import 'package:movies/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:movies/features/auth/presentation/screens/register_screen.dart';
import 'package:movies/features/auth/presentation/widgets/language_selector.dart';
import 'package:movies/features/home/presentation/screens/home_screen.dart';

import 'package:movies/shared/widgets/default_elevated_button.dart';
import 'package:movies/shared/widgets/default_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(
        authRepository: AuthRepository(authDataSource: AuthDataSource()),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    context.read<LoginCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }

        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * .072),

                  Image.asset(
                    AppAssets.logoImage,
                    height: screenHeight * .13,
                    width: screenWidth * .30,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: screenHeight * .074),

                  DefaultTextFormField(
                    controller: _emailController,
                    hintText: "Email",
                    prefixIconImageName: "email_icon",
                  ),

                  SizedBox(height: screenHeight * .024),

                  DefaultTextFormField(
                    controller: _passwordController,
                    hintText: "Password",
                    prefixIconImageName: "lock_Passowrd",
                    isPassword: true,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          ForgetPasswordScreen.routeName,
                        );
                      },
                      child: const Text("Forget Password?"),
                    ),
                  ),

                  SizedBox(height: screenHeight * .02),

                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      final bool isLoading = state is LoginLoading;

                      return DefaultElevatedButton(
                        label: isLoading ? "Logging in..." : "Login",
                        onPressed: isLoading ? null : _login,
                      );
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don’t Have Account ?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RegisterScreen.routeName,
                          );
                        },
                        child: const Text("Create One"),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * .02),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: AppColors.primary, thickness: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'OR',
                          style: AppTextStyles.textTheme.titleMedium,
                        ),
                      ),
                      Expanded(
                        child: Divider(color: AppColors.primary, thickness: 1),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * .03),

                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      final bool isLoading = state is LoginLoading;

                      return DefaultElevatedButton(
                        label: isLoading
                            ? 'Logging in...'
                            : 'Login With Google',
                        onPressed: isLoading
                            ? null
                            : () {
                                context.read<LoginCubit>().loginWithGoogle();
                              },
                        icon: SvgPicture.asset('assets/icons/google_icon.svg'),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * .03),

                  LanguageSelector(
                    firstLanguage: "🇺🇸",
                    secondLanguage: "🇪🇬",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
