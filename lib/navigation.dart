import 'package:flutter/material.dart';
import 'package:yollo/theme.dart';

/// Root Navigator key
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Scaffold messenger key
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

extension NavigatorX on NavigatorState {
  bool isCurrentRouteFirst() {
    var isCurrentRouteFirst = false;
    popUntil((route) {
      isCurrentRouteFirst = route.isFirst;
      return true;
    });
    return isCurrentRouteFirst;
  }
}

void navigateTo<T>(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute<T>(builder: (context) => widget),
  );
}

void navigateAndRome<T>(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil<T>(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}

void showErrorSnackBar(String message, {SnackBarAction? action}) {
  showSnackBar(message, action: action, backgroundColor: AppColors.greyColor);
}

void showSnackBar(
    String message, {
      SnackBarAction? action,
      Color? backgroundColor,
      EdgeInsetsGeometry? margin,
    }) {
  final scaffoldMessenger = scaffoldMessengerKey.currentState;
  if (scaffoldMessenger == null) {
    assert(false, 'ScaffoldMessenger not initiated');

    return;
  }

  scaffoldMessenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: margin,
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(
              Icons.info_outline,
              color: AppColors.whiteColor,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                 message,
                // color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
}
