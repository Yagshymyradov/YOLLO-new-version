import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/indicators.dart';
import '../../components/optimized_image.dart';
import '../../components/stepper.dart';
import '../../data/response.dart';
import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../utils/extensions.dart';
import '../../utils/theme.dart';

final orderBoxByIdProvider = FutureProvider.autoDispose.family((ref, int id) {
  final apiClient = ref.watch(apiClientProvider);
  return apiClient.getOrdersBoxById(id);
});

class FollowOrderDetails extends ConsumerWidget {
  final OrderBox? order;

  const FollowOrderDetails({
    super.key,
    required this.order,
  });

  Future<void> _launchAsCall(String path) async {
    if (!await launchUrl(Uri(scheme: 'tel', path: path))) {
      throw Exception('Could not launch $path');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.watch(apiBaseUrlProvider);
    final orderById = ref.watch(orderBoxByIdProvider(order?.id ?? 1));
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
      body: orderById.when(
        data: (data) {
          log('$baseUrl${data.box.boxImg}');
          return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            OptimizedImage(
              imageUrl: '$baseUrl${data.box.boxImg}',
              height: 320,
              fit: BoxFit.cover,
              placeholderBuilder: (c) {
                return Container(
                  height: 320,
                  decoration: BoxDecoration(
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.circular(26),
                  ),
                );
              },
              errorBuilder: (e, v, s) => Container(
                height: 320,
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: const Icon(
                  Icons.photo_camera,
                  color: Colors.blue,
                  size: 270,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${data.box.id}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  dateTime(
                    data.box.inputDate ?? DateTime.now(),
                    context,
                  ),
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
                  '${data.box.regionFromName ?? ''} ${data.box.regionToName != null ? '-' : ''} ${data.box.regionToName ?? ''}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      data.box.disCount ?? '',
                      style: const TextStyle(
                        color: AppColors.boldBlueColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      data.box.tarif?.roundedPrecisionString() ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      data.box.payment ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
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
                data.box.comment ?? '',
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            const SizedBox(height: 15),
            NumberStepper(
              width: 10,
              curStep: data.history?.length ?? 1,
              stepCompleteColor: AppColors.boldBlueColor,
              totalSteps: 6,
              inactiveColor: AppColors.whiteColor,
              currentStepColor: AppColors.boldBlueColor,
              lineWidth: 1,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()=> _launchAsCall(data.box.phoneTo ?? ''),
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
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
        },
        error: (error, stack) => NoConnectionIndicator(
          onRetryTap: () => ref.invalidate(orderBoxByIdProvider),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
