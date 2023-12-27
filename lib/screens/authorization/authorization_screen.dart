import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../assets.dart';
import '../../components/field_text.dart';
import '../../data/exceptions.dart';
import '../../extensions.dart';
import '../../navigation.dart';
import '../../providers.dart';
import '../../theme.dart';
import '../../utils/validators.dart';
import '../main_screen.dart';
import 'forgot_password_screen.dart';
import 'registration_screen.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({super.key});

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool inProgress = false;

  void updateUi() {
    if (mounted) {
      setState(() {
        //no-op
      });
    }
  }

  Future<void> onSignInTap() async {
    Keyboard.hide();

    if (!formKey.currentState!.validate()) {
      return;
    }

    final scope = ProviderScope.containerOf(context, listen: false);
    final apiClient = scope.read(apiClientProvider);
    final authController = scope.read(authControllerProvider.notifier);

    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    inProgress = true;
    updateUi();

    try {
      final response = await apiClient.signIn(
        username: username,
        password: password,
      );
      await authController.onSignedIn(response);
      if(mounted){
        navigateAndRome<Widget>(context, const MainScreen());
      }
    } catch (e) {
      log(e.toString());
      if(mounted){
        final String message;
        if(e is HttpStatusException && e.code == 401){
          message = 'Beyle ulanyjy yok';
        }else{
          message = 'Bir yalnyslyk bar';
        }
        showErrorSnackBar(message);
      }
    }
    inProgress = false;
    updateUi();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Içeri gir'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 78),
              AppIcons.logo.svgPicture(),
              const SizedBox(height: 46),
              FieldText(
                validator: (value)=> Validator.emptyField(context, value),
                prefixIcon: '+993',
                controller: usernameController,
              ),
              const SizedBox(height: 20),
              FieldText(
                validator: (value)=> Validator.emptyField(context, value),
                hintText: 'Acar sozi',
                controller: passwordController,
              ),
              const SizedBox(height: 55),
              ElevatedButton(
                onPressed: inProgress ? null : onSignInTap,
                style: AppThemes.darkTheme.elevatedButtonTheme.style,
                child: inProgress ? const CircularProgressIndicator() : const Text(
                  'Iceri gir',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 85),
              TextButton(
                onPressed: () => navigateTo<Widget>(context, const RegistrationScreen()),
                child: const Text(
                  'registrasiya',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => navigateTo<Widget>(context, const ForgotPasswordScreen()),
                child: const Text(
                  'acar sozuni unutdym',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
