import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/optimized_image.dart';
import '../../data/response.dart';
import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../utils/assets.dart';
import '../../utils/extensions.dart';
import '../../utils/navigation.dart';
import '../../utils/theme.dart';
import 'follow_order_details.dart';

class OrderTile extends ConsumerWidget {
  final OrderBox order;

  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.watch(baseUrlProvider);
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        navigateTo<Widget>(
          context,
          FollowOrderDetails(order: order),
        );
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OptimizedImage(
                imageUrl: '$baseUrl${order.boxImg}',
                width: 120,
                height: 80,
                fit: BoxFit.cover,
                placeholderBuilder: (c) => const ColoredBox(color: AppColors.greyColor),
                errorBuilder: (e, v, s) => const Icon(
                  Icons.photo_camera,
                  color: Colors.blue,
                  size: 60,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${order.id}',
                      style: AppThemes.darkTheme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: order.regionFromName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          if (order.regionToName != null)
                            TextSpan(
                              text: '-${order.regionToName}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.amount!.roundedPrecisionString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: AppColors.blueColor,
                          ),
                        ),
                        Text(
                          order.tarif!.roundedPrecisionString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          order.payment.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    dateTime(order.inputDate!, context),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGreyColor,
                    ),
                  ),
                  const SizedBox(height: 14),
                  AppIcons.arrowRight.svgPicture(),
                ],
              ),
            ],
          ),
          const Divider(color: AppColors.lightColor),
        ],
      ),
    );
  }
}
