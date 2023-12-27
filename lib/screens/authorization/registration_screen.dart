import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/drop_down_menu.dart';
import '../../components/field_text.dart';
import '../../data/response.dart';
import '../../extensions.dart';
import '../../navigation.dart';
import '../../providers.dart';
import '../../theme.dart';
import '../main_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  List<RegionResults>? regions;
  List<RegionResults>? city;

  RegionResults? selectedRegion;
  RegionResults? selectedCity;

  bool userVerify = false;
  bool inProgress = false;

  void updateUi() {
    setState(() {
      //no-op
    });
  }

  Future<void> onSignUpTap() async {
    Keyboard.hide();

    if (!formKey.currentState!.validate()) {
      return;
    }
    final scope = ProviderScope.containerOf(context, listen: false);
    final apiClient = scope.read(apiClientProvider);

    final name = usernameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final address = addressController.text.trim();
    final authController = scope.read(authControllerProvider.notifier);

    inProgress = true;
    updateUi();

    try {
      final response = await apiClient.signUp(
        password: password,
        name: name,
        phone: phone,
        regionHi: selectedRegion!.id,
        regionCity: selectedCity!.id,
        address: address,
      );
      await authController.onSignedIn(response);
      if(mounted){
        navigateAndRome<Widget>(context, const MainScreen());
      }
    } catch (e) {
      if(mounted){
        showErrorSnackBar('Nasazlyk yuze cykdy');
      }
    }
    inProgress = false;
    updateUi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasiya'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 20),
          child: Divider(color: AppColors.greyColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              FieldText(
                controller: usernameController,
                hintText: 'Ady we Familiyasy',
              ),
              const SizedBox(height: 18),
              FieldText(
                controller: emailController,
                hintText: 'Email (Hokman dal)',
              ),
              const SizedBox(height: 18),
              FieldText(
                controller: phoneController,
                hintText: '+993 65112233',
              ),
              const SizedBox(height: 18),
              FieldText(
                controller: passwordController,
                hintText: 'Acar sozi',
              ),
              const SizedBox(height: 18),
              FieldText(
                controller: addressController,
                hintText: 'Salgy',
              ),
              const SizedBox(height: 18),
              Consumer(
                builder: (context, ref, child) {
                  final regionsHi = ref.watch(regionsHiProvider);
                  final results = regionsHi.asData?.value.results;
                  return DropDownMenu<RegionResults?>(
                    value: selectedRegion,
                    values: results,
                    hint: 'Select City',
                    items: results?.map((e) {
                      return e.name ?? '-';
                    }).toList(),
                    children: results
                        ?.map(
                          (e) => DropdownMenuItem<RegionResults?>(
                            value: e,
                            child: Text(
                              e.name,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        selectedRegion = val;
                        ref.read(regionsCityProvider(selectedRegion!.name));
                        updateUi();
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 18),
              Consumer(
                builder: (context, ref, child) {
                  final regionsCity = ref.watch(regionsCityProvider(selectedRegion?.name ?? '-'));
                  final results = regionsCity.asData?.value.results;
                  return DropDownMenu<RegionResults?>(
                    value: selectedCity,
                    values: results,
                    isLoading: regionsCity.isLoading,
                    hint: 'Select City',
                    items: results?.map((e) {
                      return e.name ?? '-';
                    }).toList(),
                    children: results
                        ?.map(
                          (e) => DropdownMenuItem<RegionResults?>(
                            value: e,
                            child: Text(
                              e.name,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        selectedCity = val;
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 44),
              Row(
                children: [
                  Checkbox(
                    activeColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => const BorderSide(color: AppColors.whiteColor),
                    ),
                    value: userVerify,
                    onChanged: (val) {
                      userVerify = val!;
                      updateUi();
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      userVerify = !userVerify;
                      updateUi();
                    },
                    child: const Text(
                      'Okadym we ylalasyan',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Ulanyjy ylalasygy',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: onSignUpTap,
                style: AppThemes.darkTheme.elevatedButtonTheme.style,
                child: const Text('Hasap as'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class City {}
