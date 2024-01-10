import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yollo/screens/profile_screen/widgets/language_change_widget.dart';

import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../utils/assets.dart';
import '../../utils/navigation.dart';
import '../../utils/theme.dart';
import '../authorization/authorization_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool inProgress = false;

  void updateUi() {
    setState(() {
      //no-op
    });
  }

  Future<void> onLogOutTap() async {
    final scope = ProviderScope.containerOf(context, listen: false);
    final apiClient = scope.read(apiClientProvider);
    final authController = scope.read(authControllerProvider.notifier);
    log(authController.authToken.toString());
    inProgress = true;
    updateUi();
    try {
      await apiClient.logOut(authController.authToken);
      if (mounted) {
        log('token deleted');
        await replaceRootScreen(context, const AuthorizationScreen());
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(e.toString());
      }
    }
    inProgress = false;
    updateUi();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider);
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 20),
          child: Divider(
            color: AppColors.greyColor,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          AppIcons.person.svgPicture(),
          const SizedBox(height: 16),
          Center(
            child: Text(
              user?.username ?? '',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              '+993${user?.phone}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const LanguageChangeWidget(),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: Text(
              l10n.changeLanguage,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: const Text(
              'Dil uytget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: const Text(
              'Dil uytget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: const Text(
              'Dil uytget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: const Text(
              'Dil uytget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: const Text(
              'Dil uytget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
          ListTile(
            leading: const Icon(Icons.outlined_flag_outlined),
            title: const Text(
              'Dil uytget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.chevronDown.svgPicture(),
          ),
          Consumer(
            builder: (context, ref, child) {
              final apiClient = ref.read(apiClientProvider);
              final authController = ref.read(authControllerProvider);
              return ListTile(
                onTap: onLogOutTap,
                leading: const Icon(Icons.outlined_flag_outlined),
                title: const Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: AppIcons.chevronDown.svgPicture(),
              );
            },
          ),
        ],
      ),
    );
  }
}
