import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/alert_dialog.dart';
import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../utils/assets.dart';
import '../../utils/navigation.dart';
import '../../utils/theme.dart';
import '../splash_screen.dart';
import 'widgets/language_change_widget.dart';

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
    alertDialog(
      context,
      title: context.l10n.confirmLogout,
      onTap: () async{
        final apiClient = ref.read(apiClientProvider);
        final authController = ref.read(authControllerProvider.notifier);
        inProgress = true;
        updateUi();
        try {
          await apiClient.logOut();
          await authController.signOut();
          if (mounted) {
            // ignore: unawaited_futures
            replaceRootScreen(context, const SplashScreen());
          }
        } catch (e) {
          if (mounted) {
            showErrorSnackBar(context.l10n.hasErrorPleaseReaped);
          }
        }
        inProgress = false;
        updateUi();
      },
    );
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
            leading: AppIcons.profile.svgPicture(),
            title: Text(
              l10n.changeProfile,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.arrowRight.svgPicture(),
          ),
          ListTile(
            leading: AppIcons.policies.svgPicture(),
            title: Text(
              l10n.termsAndPolitics,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.arrowRight.svgPicture(),
          ),
          ListTile(
            leading: AppIcons.help.svgPicture(),
            title: Text(
              l10n.helpSupport,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.arrowRight.svgPicture(),
          ),
          ListTile(
            leading: AppIcons.help.svgPicture(),
            title: Text(
              l10n.callOperator,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListTile(
            leading: AppIcons.tikTok.svgPicture(),
            title: Text(
              l10n.siteYollo,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListTile(
            leading: AppIcons.instagram.svgPicture(),
            title: Text(
              l10n.siteYollo,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListTile(
            onTap: onLogOutTap,
            leading: AppIcons.logOut.svgPicture(),
            title: Text(
              l10n.logOut,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: AppIcons.arrowRight.svgPicture(),
          ),
        ],
      ),
    );
  }
}
