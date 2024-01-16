import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../utils/theme.dart';

void alertDialog(
  BuildContext context, {
  required String title,
  required VoidCallback? onTap,
}) {
  final l10n = context.l10n;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actionsPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.buttonColor),
      ),
      backgroundColor: AppColors.backgroundColor,
      insetPadding: const EdgeInsets.all(24),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width - 70,
        child: Text(
          title,
          style: AppThemes.darkTheme.textTheme.displayLarge,
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(
                  l10n.cancel,
                  style: AppThemes.darkTheme.textTheme.displayMedium,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: (){
                  if(onTap != null){
                    onTap();
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  l10n.ok,
                  style: AppThemes.darkTheme.textTheme.displayMedium,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
