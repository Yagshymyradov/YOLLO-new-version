import 'package:flutter/material.dart';

import '../l10n/l10n.dart';

class Validator {
  static String? emptyField(
    BuildContext context,
    String? value, {
    String? emptyMessage,
  }) {
    if (value == null) {
      return null;
    }
    final trimmedValue = value.trimRight();
    if (trimmedValue.isEmpty) {
      return emptyMessage ?? 'context.l10n.fillBlank';
    }
    return null;
  }

  static String? phoneValidator(BuildContext context, String? value) {
    // final localization = AppLocalizations.of(context);

    if (value == null || value.isEmpty) return 'localization.providingPhoneNumValidationMessage';

    if (value.length >= 2) {
      const allowedPhonePrefixes = [
        '61',
        '62',
        '63',
        '64',
        '65',
      ];
      if (allowedPhonePrefixes.contains(value.substring(0, 2))) {
        return null;
      }
    }
    return 'localization.providingValidPhoneNumValidationMessage';
  }
}
