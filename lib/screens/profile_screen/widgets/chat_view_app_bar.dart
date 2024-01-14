import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatViewAppBar extends StatelessWidget {
  const ChatViewAppBar({
    required this.name,
    required this.isLoading,
    required this.subTitle,
    required this.fetchingStatus,
    required this.onBack,
    this.bytes,
    this.isBase64Url = false,
    super.key,
  });

  final String name;
  final bool isLoading;
  final String subTitle;
  final String fetchingStatus;
  final VoidCallback onBack;
  final bool isBase64Url;
  final Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    // DateTime.;
    return AppBar(
      centerTitle: false,
      leadingWidth: 32,
      backgroundColor: Colors.black12,
      leading: GestureDetector(
        onTap: onBack,
        child: Container(
          margin: const EdgeInsets.only(left: 14),
          color: Colors.transparent,
          child: const Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: Icon(CupertinoIcons.chevron_back),
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          FittedBox(
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: const Icon(Icons.person_outline_outlined),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 3,
              ),
              if (isLoading) ...[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 14,
                      width: 14,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      fetchingStatus,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ] else
                const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
