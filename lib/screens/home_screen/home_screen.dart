import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../../utils/assets.dart';
import '../../utils/navigation.dart';
import '../../utils/theme.dart';
import 'create_order.dart';
import 'create_order_auto.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Center(child: AppIcons.logo.svgPicture(height: 23)),
              const SizedBox(height: 47),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.whiteColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.yollo,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l10n.aboutApp,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l10n.workTime,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 76),
              const CreateUserAuto(),
              const SizedBox(height: 19),
              ListTile(
                onTap: () => navigateTo<Widget>(context, const CreateOrder()),
                splashColor: AppColors.buttonColor,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppColors.whiteColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: const EdgeInsets.all(10),
                title: Text(
                  l10n.sendCargo,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  l10n.completeOrder,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: AppIcons.box.svgPicture(height: 54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
