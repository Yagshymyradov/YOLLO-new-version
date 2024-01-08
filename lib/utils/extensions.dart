
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/l10n.dart';

extension Keyboard on Never {
  static void hide() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

late final _dateFormat = DateFormat('dd MMM HH:mm', 'en');

String dateTime(DateTime dateTime, BuildContext context) {
  final Duration timePassed = DateTime.now().difference(dateTime);

  final minutesDiff = timePassed.inMinutes;

  if (minutesDiff == 0) {
    return context.l10n.justNow;
  }

  if (minutesDiff < 60) {
    return context.l10n.lastTimeInMinutes(minutesDiff);
  }

  final hoursDiff = timePassed.inHours;
  if (hoursDiff < 3) {
    return context.l10n.lastTimeInHours(hoursDiff);
  }

  final String createdAt = _dateFormat.format(dateTime);
  return createdAt;
}
