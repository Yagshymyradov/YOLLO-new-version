import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/field_text.dart';
import '../../data/exceptions.dart';
import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../utils/assets.dart';
import '../../utils/extensions.dart';
import '../../utils/navigation.dart';
import '../../utils/theme.dart';
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
      final response = await apiClient.login(
        username: username,
        password: password,
      );
      authController.onSignedIn(response);
      if (mounted) {
        navigateAndRome<Widget>(context, const MainScreen());
      }
    } catch (e) {
      if (mounted) {
        final String message;
        final l10n = context.l10n;
        log(e.toString());
        if (e is JsonIOException) {
          message = l10n.incorrectUser;
        } else {
          message = l10n.hasErrorPleaseReaped;
        }
        showErrorSnackBar(message);
      }
    }
    inProgress = false;
    updateUi();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.login,
          style: AppThemes.darkTheme.textTheme.titleMedium,
        ),
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
                validator: (value) => Validator.phoneValidator(context, value),
                prefixIcon: '+993',
                hintText: '61233377',
                controller: usernameController,
                keyboardType: TextInputType.phone,
                inputFormatters: [LengthLimitingTextInputFormatter(8)],
              ),
              const SizedBox(height: 20),
              FieldText(
                validator: (value) => Validator.emptyField(context, value),
                hintText: l10n.password,
                controller: passwordController,
              ),
              const SizedBox(height: 55),
              ElevatedButton(
                onPressed: inProgress ? null : onSignInTap,
                style: AppThemes.darkTheme.elevatedButtonTheme.style,
                child: inProgress
                    ? const CircularProgressIndicator()
                    : Text(
                        l10n.login,
                        style: AppThemes.darkTheme.textTheme.displayLarge,
                      ),
              ),
              const SizedBox(height: 85),
              TextButton(
                onPressed: () => navigateTo<Widget>(
                  context,
                  const RegistrationScreen(),
                ),
                child: Text(
                  l10n.registration,
                  style: AppThemes.darkTheme.textTheme.displayLarge,
                ),
              ),
              TextButton(
                onPressed: () => navigateTo<Widget>(
                  context,
                  const ForgotPasswordScreen(),
                ),
                child: Text(
                  l10n.forgotPassword,
                  style: AppThemes.darkTheme.textTheme.displayLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
