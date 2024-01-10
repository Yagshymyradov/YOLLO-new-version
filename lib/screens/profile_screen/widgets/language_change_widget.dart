import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/l10n.dart';
import '../../../providers.dart';
import '../../../utils/assets.dart';
import '../../../utils/theme.dart';

class LanguageChangeWidget extends ConsumerStatefulWidget {
  const LanguageChangeWidget({super.key});

  @override
  ConsumerState<LanguageChangeWidget> createState() => _LanguageChangeWidgetState();
}

class _LanguageChangeWidgetState extends ConsumerState<LanguageChangeWidget> {

  void updateUi() {
    setState(() {
      //no-op
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(settingsControllerProvider.notifier);
    final l10n = context.l10n;
    return ExpansionTile(
      shape: LinearBorder.none,
      trailing: AppIcons.chevronDown.svgPicture(),
      title: Row(
        children: [
          const Icon(Icons.outlined_flag_outlined),
          const SizedBox(width: 41),
          Text(
            l10n.changeLanguage,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      children: [
        Row(
          children: [
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  locale.updateLocale(const Locale('tk'));
                  updateUi();
                },
                style: ButtonStyle(
                  backgroundColor: locale.locale.languageCode.contains('tk')
                      ? null
                      : const MaterialStatePropertyAll(Colors.transparent),
                  side: locale.locale.languageCode.contains('tk')
                      ? null
                      : const MaterialStatePropertyAll(
                    BorderSide(color: AppColors.whiteColor),
                  ),
                ),
                child: Text(l10n.tm, style: AppThemes.darkTheme.textTheme.displayLarge),
              ),
            ),
            const SizedBox(width: 30),
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  locale.updateLocale(const Locale('ru'));
                  updateUi();
                },
                style: ButtonStyle(
                  backgroundColor: locale.locale.languageCode.contains('ru')
                      ? null
                      : const MaterialStatePropertyAll(Colors.transparent),
                  side: locale.locale.languageCode.contains('ru')
                      ? null
                      : const MaterialStatePropertyAll(
                    BorderSide(color: AppColors.whiteColor),
                  ),
                ),
                child: Text(
                  l10n.rus,
                  style: AppThemes.darkTheme.textTheme.displayLarge,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
