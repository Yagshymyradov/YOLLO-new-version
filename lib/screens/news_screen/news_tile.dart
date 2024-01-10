import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/optimized_image.dart';
import '../../data/response.dart';
import '../../providers.dart';
import '../../utils/assets.dart';
import '../../utils/extensions.dart';
import '../../utils/navigation.dart';
import '../../utils/theme.dart';
import 'news_details_sccreen.dart';

class NewsTile extends ConsumerWidget {
  final Notifications news;

  const NewsTile({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.watch(baseUrlProvider);
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        navigateTo<Widget>(
          context,
          NewsDetailsScreen(news: news),
        );
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OptimizedImage(
                imageUrl: '$baseUrl${news.image}',
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
                    const SizedBox(height: 5),
                    Text(
                      news.theme,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.blueColor,
                      ),
                    ),
                    Text(
                      news.mainTxt,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    dateTime(news.inputDate, context),
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
