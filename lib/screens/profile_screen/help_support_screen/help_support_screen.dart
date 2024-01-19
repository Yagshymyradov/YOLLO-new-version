import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yollo_chat_ui/chat_ui.dart';

import '../../../data/chat_response.dart';
import '../../../l10n/l10n.dart';
import '../../../providers.dart';
import '../widgets/chat_view_app_bar.dart';

final getFeedbackProviders = FutureProvider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return apiClient.getFeedbacks();
});

class HelpSupportScreen extends ConsumerStatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  ConsumerState<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends ConsumerState<HelpSupportScreen> {

  void _onMessageSubmitted({
    PartialText? message,
  }) {
    if (message?.text.isEmpty ?? true) return;

    final msg = Feedbacks(
      comment: message?.text,
      key: UniqueKey().toString(),
    );

    final chatController = ref.read(chatControllerProvider.notifier);
    chatController.sendMessage(message: msg);
  }

  void _onResendMessage({
    MessageModel? message,
  }) {
    if (message is! TextMessageModel) {
      return;
    }
    if (message.text.isEmpty) return;
    final msg = Feedbacks(
      comment: message.text,
      key: message.id,
      reSendKey: UniqueKey().toString(),
    );

    final chatController = ref.read(chatControllerProvider.notifier);
    chatController.onReSendMessage(body: msg);
  }

  void getMessages() {
    final chatController = ref.read(chatControllerProvider.notifier);
    chatController.loadMessages(ref);
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatControllerProvider);
    final feedbacks = ref.watch(getFeedbackProviders);
    final l10n = context.l10n;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ChatViewAppBar(
          onBack: () => Navigator.pop(context),
          name: l10n.helpSupport,
          isLoading: feedbacks.isLoading,
          subTitle: 'Sub title',
          fetchingStatus: ' Loading messsage',
        ),
      ),
      body: Chat(
        emptyStateText: 'emptyStateText',
        onMessageTap: (context, m) {
          if (m.status == Status.error) {
            _onResendMessage(
              message: m,
            );
          }
        },
        emptyState: feedbacks.isLoading ? const SizedBox.shrink() : null,
        messages: chatState?.messages ?? [],
        onSendPressed: (message) => _onMessageSubmitted(
          message: message,
        ),
        showUserAvatars: true,
        showUserNames: true,
        customDateHeaderText: (date) {
          final cDate = chatDate(date);
          return cDate;
        },
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        user: const UserModel(
          id: '',
          firstName: 'username',
          lastName: '',
          isBase64UrlOfAvatar: true,
        ),
        onEmojiPressed: (emj) {},
        onEmptyPressed: (emj) {},
      ),
    );
  }
}
