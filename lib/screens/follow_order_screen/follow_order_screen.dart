import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../assets.dart';
import '../../extensions.dart';
import '../../l10n/l10n.dart';
import '../../navigation.dart';
import '../../providers.dart';
import '../../theme.dart';
import 'follow_order_details.dart';

final ordersBoxProvider = FutureProvider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return apiClient.getOrdersBox();
});

class FollowOrderScreen extends ConsumerStatefulWidget {
  const FollowOrderScreen({super.key});

  @override
  ConsumerState<FollowOrderScreen> createState() => _FollowOrderScreenState();
}

class _FollowOrderScreenState extends ConsumerState<FollowOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ordersBoxProvider);
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.follow),
        actions: [
          AppIcons.add.svgPicture(),
          const SizedBox(width: 20),
        ],
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 20),
          child: Divider(
            color: AppColors.greyColor,
          ),
        ),
      ),
      body: orders.when(
        data: (data) => ListView.separated(
          itemBuilder: (context, index) {
            final order = data.boxes[index];
            return GestureDetector(
              onTap: () {
                navigateTo<Widget>(
                    context,
                    FollowOrderDetails(
                      order: order,
                    ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 110,
                    child: Icon(
                      Icons.photo_camera,
                      color: Colors.blue,
                      size: 60,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '#${order.id}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${order.regionFromName ?? ''} ${order.regionToName != null ? '-' : ''} ${order.regionToName ?? ''}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                order.discount.toString(),
                                style: const TextStyle(
                                  color: AppColors.boldBlueColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                order.delivery.toString(),
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                order.payment.toString(),
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${l10n.status}: ',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: order.status,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.boldBlueColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            dateTime(order.inputDate ?? DateTime.now(), context),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColors.darkGreyColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Icon(Icons.arrow_forward_ios_rounded),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(color: AppColors.whiteColor);
          },
          itemCount: 3,
        ),
        error: (error, stack) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
