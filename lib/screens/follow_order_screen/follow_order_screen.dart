import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/indicators.dart';
import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../utils/assets.dart';
import '../../utils/theme.dart';
import 'order_tile.dart';

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
            itemCount: data.boxes.length,
          ),
          error: (error, stack) {
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
