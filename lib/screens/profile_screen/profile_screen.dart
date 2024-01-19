import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/alert_dialog.dart';
import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../utils/assets.dart';
import '../../utils/navigation.dart';
import '../../utils/theme.dart';
import '../splash_screen.dart';
import 'help_support_screen/help_support_screen.dart';
import 'set_profile_screen.dart';
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

  Future<void> _launchAsInAppWebViewWithCustomHeaders(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> onLogOutTap() async {
    alertDialog(
      context,
      title: context.l10n.confirmLogout,
      onTap: () async {
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
              style: AppThemes.darkTheme.textTheme.displayLarge?.copyWith(fontSize: 28),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              '+993${user?.phone}',
              style:
                  AppThemes.darkTheme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w100),
            ),
          ),
          const SizedBox(height: 10),
          const LanguageChangeWidget(),
          ListTile(
            onTap: () => navigateTo<Widget>(context, const SetProfileScreen()),
            leading: AppIcons.profile.svgPicture(),
            title: Text(
              l10n.changeProfile,
              style: AppThemes.darkTheme.textTheme.bodyMedium,
            ),
            trailing: AppIcons.arrowRight.svgPicture(),
          ),
          ListTile(
            leading: AppIcons.policies.svgPicture(),
            title: Text(
              l10n.termsAndPolitics,
              style: AppThemes.darkTheme.textTheme.bodyMedium,
            ),
            trailing: AppIcons.arrowRight.svgPicture(),
          ),
          ListTile(
            onTap: () => navigateTo<Widget>(context, HelpSupportScreen()),
            leading: AppIcons.help.svgPicture(),
            title: Text(
              l10n.helpSupport,
              style: AppThemes.darkTheme.textTheme.bodyMedium,
            ),
            trailing: AppIcons.arrowRight.svgPicture(),
          ),
          ListTile(
            leading: AppIcons.help.svgPicture(),
            title: Text(
              l10n.callOperator,
              style: AppThemes.darkTheme.textTheme.bodyMedium,
            ),
          ),
          ListTile(
            onTap: () => _launchAsInAppWebViewWithCustomHeaders(
              Uri.parse('https://www.tiktok.com/@yollo.com.tm?_t=8iJTcdXhgAc&_r=1'),
            ),
            leading: AppIcons.tikTok.svgPicture(),
            title: Text(
              l10n.siteYollo,
              style: AppThemes.darkTheme.textTheme.bodyMedium,
            ),
          ),
          ListTile(
            onTap: () => _launchAsInAppWebViewWithCustomHeaders(
              Uri.parse('https://www.instagram.com/yollo.com.tm?igshid=NGVhN2U2NjQ0Yg=='),
            ),
            leading: AppIcons.instagram.svgPicture(),
            title: Text(
              l10n.siteYollo,
              style: AppThemes.darkTheme.textTheme.bodyMedium,
            ),
          ),
          ListTile(
            onTap: onLogOutTap,
            leading: AppIcons.logOut.svgPicture(),
            title: Text(
              l10n.logOut,
              style: AppThemes.darkTheme.textTheme.bodyMedium,
            ),
            trailing: AppIcons.arrowRight.svgPicture(),
          ),
        ],
      ),
    );
  }
}
