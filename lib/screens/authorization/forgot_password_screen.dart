import 'package:flutter/material.dart';

import '../../assets.dart';
import '../../components/field_text.dart';
import '../../navigation.dart';
import '../../theme.dart';
import 'registration_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yza'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 20),
          child: Divider(
            color: AppColors.greyColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 48),
              AppIcons.logo.svgPicture(),
              const SizedBox(height: 46),
              const FieldText(
                prefixIcon: '+993',
              ),
              const SizedBox(height: 20),
              const FieldText(
                hintText: 'Acar sozi',
              ),
              const SizedBox(height: 20),
              const FieldText(
                hintText: 'Tassyklama kody',
              ),
              const SizedBox(height: 55),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, 46)),
                ),
                child: const Text(
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
            ],
          ),
        ),
      ),
    );
  }
}
