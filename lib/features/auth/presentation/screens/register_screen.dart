import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies/features/auth/data/data_sources/auth_data_source.dart';
import 'package:movies/features/auth/data/repositories/auth_repository.dart';
import 'package:movies/features/auth/presentation/cubit/register_cubit.dart';
import 'package:movies/features/auth/presentation/screens/login_screen.dart';
import 'package:movies/features/auth/presentation/widgets/avatar_selector.dart';
import 'package:movies/features/auth/presentation/widgets/language_selector.dart';

import 'package:movies/shared/widgets/default_elevated_button.dart';
import 'package:movies/shared/widgets/default_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "/register";

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(
        authRepository: AuthRepository(authDataSource: AuthDataSource()),
      ),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  void _createAccount() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<RegisterCubit>().register(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Account created successfully")),
          );
        }

        if (state is RegisterError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("Register"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const AvatarSelector(),

                  SizedBox(height: screenHeight * .024),

                  DefaultTextFormField(
                    hintText: "Name",
                    prefixIconImageName: "name_icon",
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: screenHeight * .024),

                  DefaultTextFormField(
                    hintText: "Email",
                    prefixIconImageName: "email_icon",
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your email";
                      }

                      if (!value.contains("@")) {
                        return "Please enter a valid email";
                      }

                      return null;
                    },
                  ),

                  SizedBox(height: screenHeight * .024),

                  DefaultTextFormField(
                    hintText: "Password",
                    prefixIconImageName: "lock_Passowrd",
                    isPassword: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }

                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }

                      return null;
                    },
                  ),

                  SizedBox(height: screenHeight * .024),

                  DefaultTextFormField(
                    hintText: "Confirm Password",
                    prefixIconImageName: "lock_Passowrd",
                    isPassword: true,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password";
                      }

                      if (value != _passwordController.text) {
                        return "Passwords do not match";
                      }

                      return null;
                    },
                  ),

                  SizedBox(height: screenHeight * .024),

                  DefaultTextFormField(
                    hintText: "Phone Number",
                    prefixIconImageName: "phone_icon",
                    controller: _phoneController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your phone number";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: screenHeight * .024),

                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      final bool isLoading = state is RegisterLoading;

                      return DefaultElevatedButton(
                        label: isLoading
                            ? "Creating Account..."
                            : "Create Account",
                        onPressed: isLoading ? () {} : _createAccount,
                      );
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already Have Account ?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            LoginScreen.routeName,
                          );
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  ),

                  const LanguageSelector(
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
