import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/optimized_image.dart';
import '../../data/response.dart';
import '../../l10n/l10n.dart';
import '../../providers.dart';
import '../../utils/extensions.dart';
import '../../utils/theme.dart';

class NewsDetailsScreen extends ConsumerWidget{
  final Notifications news;

  const NewsDetailsScreen({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.watch(baseUrlProvider);
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
          OptimizedImage(
            imageUrl: '$baseUrl${news.image}',
            height: 320,
            fit: BoxFit.cover,
            placeholderBuilder: (c) {
              log('$baseUrl${news.image}');
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
            children: [
              Expanded(
                child: Text(
                  news.theme,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                dateTime(
                  news.inputDate,
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
          const SizedBox(height: 20),
          Text(
            news.mainTxt,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.darkGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}
