import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../l10n/l10n.dart';
import '../utils/theme.dart';

class NoConnectionIndicator extends StatelessWidget {
  final VoidCallback? onRetryTap;

  const NoConnectionIndicator({super.key, this.onRetryTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        Text(
          context.l10n.hasErrorPleaseReaped,
          style: appThemeData.textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onRetryTap,
          style: ButtonStyle(
            minimumSize: MaterialStatePropertyAll(
              Size(RenderErrorBox.minimumWidth, 40),
            ),
          ),
          child: Text(
            context.l10n.refresh,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}

class NoProductsIndicator extends StatelessWidget {

  const NoProductsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        Text(
          context.l10n.noProducts,
          style: appThemeData.textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
