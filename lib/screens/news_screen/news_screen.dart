import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/indicators.dart';
import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../utils/assets.dart';
import '../../utils/theme.dart';
import 'news_tile.dart';

final getNewsProvider = FutureProvider((ref) {
  final locale = ref.watch(settingsControllerProvider).locale;
  final apiClient = ref.watch(apiClientProvider);
  return apiClient.getNews(locale.languageCode);
});

class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(getNewsProvider);
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.news),
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 20),
          child: Divider(
            color: AppColors.greyColor,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return ref.invalidate(getNewsProvider);
        },
        child: news.when(
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: false,
          data: (data) {
            return data.notifications == null
              ? Container()
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    return NewsTile(
                      news: data.notifications![index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(color: AppColors.whiteColor);
                  },
                  itemCount: data.notifications!.length,
                );
          },
          error: (error, stack) {
            return NoConnectionIndicator(
              onRetryTap: () => ref.refresh(getNewsProvider),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
