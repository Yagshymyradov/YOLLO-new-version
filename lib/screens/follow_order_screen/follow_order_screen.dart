import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/indicators.dart';
import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../utils/assets.dart';
import '../../utils/navigation.dart';
import '../../utils/theme.dart';
import '../home_screen/create_order_auto.dart';
import 'all_orders_follow_screen.dart';
import 'order_tile.dart';

final ordersBoxProvider = FutureProvider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return apiClient.getOrdersBox();
});

class FollowOrderScreen extends ConsumerWidget {
  const FollowOrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersBoxProvider);
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: TextButton(
          onPressed: () => navigateTo<Widget>(context, const AllOrdersFollowScreen()),
          child: Text(
            l10n.all,
            style: AppThemes.darkTheme.textTheme.bodyMedium,
          ),
        ),
        title: Text(l10n.follow),
        actions: [
          GestureDetector(
            onTap: () => onCreateOrderButtonTap(context),
            child: AppIcons.add.svgPicture(),
          ),
          const SizedBox(width: 20),
        ],
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 20),
          child: Divider(
            color: AppColors.greyColor,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return ref.refresh(ordersBoxProvider);
        },
        child: orders.when(
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: false,
          data: (data) => ListView.separated(
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              final order = data.boxes[index];
              return OrderTile(order: order);
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: AppColors.whiteColor,
                height: 30,
              );
            },
            itemCount: data.boxes.length > 5 ? 5 : data.boxes.length,
          ),
          error: (error, stack) {
            log(error.toString());
            log(stack.toString());
            return NoConnectionIndicator(
              onRetryTap: () => ref.refresh(ordersBoxProvider),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
