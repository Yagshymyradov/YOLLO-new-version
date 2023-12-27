import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/stepper.dart';
import '../../data/response.dart';
import '../../extensions.dart';
import '../../l10n/l10n.dart';
import '../../theme.dart';

class FollowOrderDetails extends ConsumerWidget {
  final Boxes? order;

  const FollowOrderDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.follow),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 20),
          child: Divider(color: AppColors.greyColor),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            height: 320,
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(26),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#${order?.id}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Text(
                dateTime(order?.inputDate ?? DateTime.now(), context),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkGreyColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${order?.regionFromName ?? ''} ${order?.regionToName != null ? '-' : ''} ${order?.regionToName ?? ''}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
              ),
              Row(
                children: [
                  Text(
                    order?.discount ?? '',
                    style: const TextStyle(
                      color: AppColors.boldBlueColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    order?.delivery ?? '',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    order?.payment ?? '',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 70,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.greyColor),
            ),
            child: Text(
              order?.comment ?? '',
              maxLines: 3,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
            ),
          ),
          const SizedBox(height: 15),
          const NumberStepper(
            width: 10,
            curStep: 1,
            stepCompleteColor: AppColors.boldBlueColor,
            totalSteps: 6,
            inactiveColor: AppColors.whiteColor,
            currentStepColor: AppColors.boldBlueColor,
            lineWidth: 1,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  side: const BorderSide(color: AppColors.greyColor),
                  borderRadius: BorderRadius.circular(23),
                ),
              ),
            ),
            child: Text(
              l10n.recipient,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
