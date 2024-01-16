import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/drop_down_menu.dart';
import '../../components/field_text.dart';
import '../../data/response.dart';
import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../utils/extensions.dart';
import '../../utils/navigation.dart';
import '../../utils/theme.dart';
import '../../utils/validators.dart';

class SetProfileScreen extends StatefulWidget {
  const SetProfileScreen({super.key});

  @override
  State<SetProfileScreen> createState() => _SetProfileScreenState();
}

class _SetProfileScreenState extends State<SetProfileScreen> {
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

  bool inProgress = false;
  bool isValidate = false;

  void updateUi() {
    setState(() {
      //no-op
    });
  }

  void initialValues() {
    final scope = ProviderScope.containerOf(context, listen: false);
    final user = scope.read(authControllerProvider);

    usernameController.text = user?.username ?? '';
    emailController.text = user?.email ?? '';
    phoneController.text = user?.phone ?? '';
    addressController.text = user?.address ?? '';
    selectedRegion = regions?.firstWhere((el) {
      log(el.hiRegion);
      return el.hiRegion == user?.regionHi;
    });
    if(city?.isNotEmpty ?? false){
      selectedCity = city?.firstWhere((el) => el.id == user?.regionId);
    }
  }

  Future<void> onUpdateProfileButtonTap() async {
    Keyboard.hide();

    if (!formKey.currentState!.validate()) {
      isValidate = true;
      return;
    }

    final scope = ProviderScope.containerOf(context, listen: false);
    final apiClient = scope.read(apiClientProvider);
    final authController = scope.read(authControllerProvider.notifier);

    final name = usernameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final address = addressController.text.trim();

    inProgress = true;
    updateUi();

    try {
      final response = await apiClient.updateUser(
        password: password,
        name: name,
        email: email,
        phone: phone,
        regionId: selectedRegion!.id,
        address: address,
      );

      authController.updateUser(response);

      if (mounted) {
        showSnackBar('success', backgroundColor: AppColors.greenColor);
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context.l10n.hasErrorPleaseReaped);
      }
    }
    inProgress = false;
    updateUi();
  }

  @override
  void initState() {
    super.initState();
    initialValues();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(l10n.changeProfile),
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
          key: formKey,
          child: Column(
            children: [
              FieldText(
                controller: usernameController,
                hintText: l10n.fio,
                validator: (value) => Validator.emptyField(context, value),
              ),
              const SizedBox(height: 18),
              FieldText(
                controller: emailController,
                hintText: l10n.emailHint,
              ),
              const SizedBox(height: 18),
              FieldText(
                //TODO CHANGE IT AFTER TESTING
                // validator: (value) => Validator.phoneValidator(context, value),
                prefixIcon: '+993',
                hintText: '61233377',
                controller: phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [LengthLimitingTextInputFormatter(8)],
              ),
              const SizedBox(height: 18),
              FieldText(
                controller: passwordController,
                hintText: l10n.password,
              ),
              const SizedBox(height: 18),
              FieldText(
                controller: addressController,
                hintText: l10n.address,
                validator: (value) => Validator.emptyField(context, value),
              ),
              const SizedBox(height: 18),
              Consumer(
                builder: (context, ref, child) {
                  final regionsHi = ref.watch(regionsHiProvider);
                  final results = regionsHi.asData?.value.results;
                  return DropDownMenu<RegionResults?>(
                    value: selectedRegion,
                    values: results,
                    hint: l10n.chooseRegion,
                    borderColor: selectedRegion == null && isValidate
                        ? AppColors.redColor
                        : AppColors.whiteColor,
                    validator: (v) => v == null ? context.l10n.chooseRegion : null,
                    items: results?.map((e) => e.name ?? '-').toList(),
                    children: results
                        ?.map(
                          (e) => DropdownMenuItem<RegionResults?>(
                        value: e,
                        child: Text(e.name),
                      ),
                    )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        selectedRegion = val;
                        ref.read(regionsCityProvider(selectedRegion!.name));
                        selectedCity = null;
                        updateUi();
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 18),
              Consumer(
                builder: (context, ref, child) {
                  final regionsCity = ref.watch(
                    regionsCityProvider(selectedRegion?.name ?? '-'),
                  );
                  final results = regionsCity.asData?.value.results;
                  return DropDownMenu<RegionResults?>(
                    value: selectedCity,
                    values: results,
                    isLoading: regionsCity.isLoading,
                    hint: l10n.chooseCity,
                    borderColor: selectedCity == null && isValidate
                        ? AppColors.redColor
                        : AppColors.whiteColor,
                    validator: (v) => v == null ? context.l10n.chooseRegion : null,
                    items: results?.map((e) {
                      return e.name ?? '-';
                    }).toList(),
                    children: results
                        ?.map(
                          (e) => DropdownMenuItem<RegionResults?>(
                        value: e,
                        child: Text(e.name),
                      ),
                    )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        selectedCity = val;
                        updateUi();
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 44),
              ElevatedButton(
                onPressed: inProgress ? null : onUpdateProfileButtonTap,
                child: inProgress ? const CircularProgressIndicator() : Text(
                  l10n.saveIt,
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
