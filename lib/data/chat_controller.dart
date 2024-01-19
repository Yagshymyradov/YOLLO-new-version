import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yollo_chat_ui/chat_ui.dart';

import '../providers.dart';
import 'apiClient.dart';
import 'chat_response.dart';

enum SyncMessageStatus { init, loading, error, success }

enum SendMessageStatus { init, loading, error, success }

class ChatState {
  const ChatState({
    this.syncMessageStatus = SyncMessageStatus.init,
    this.sendMessageStatus = SendMessageStatus.init,
    this.messages,
  });

  final SyncMessageStatus syncMessageStatus;
  final SendMessageStatus sendMessageStatus;
  final List<MessageModel>? messages;

  ChatState.empty()
      : messages = null,
        syncMessageStatus = SyncMessageStatus.init,
        sendMessageStatus = SendMessageStatus.init;

  ChatState copyWith({
    SyncMessageStatus? syncMessageStatus,
    SendMessageStatus? sendMessageStatus,
    List<MessageModel>? messages,
  }) {
    return ChatState(
      syncMessageStatus: syncMessageStatus ?? this.syncMessageStatus,
      sendMessageStatus: sendMessageStatus ?? this.sendMessageStatus,
      messages: messages ?? this.messages,
    );
  }
}

class ChatController extends StateNotifier<ChatState?> {
  ChatController(super._state, this.apiClient);

  final ApiClient apiClient;

  Future<void> loadMessages(WidgetRef ref) async {
    try {
      final statusMessageState = state?.copyWith(syncMessageStatus: SyncMessageStatus.loading);
      state = statusMessageState;

      final res = await apiClient.getFeedbacks();

      final messagesComments = res?.feedbacks?.where(
        (el) => el.comment != null && el.comment != '',
      );

      final messagesAns = res?.feedbacks
          ?.where(
            (el) => el.answer != null && el.answer != '',
          )
          .toList();

      final comments = messagesComments
          ?.map(
            (e) => toComment(e, status: Status.sent),
          )
          .toList();

      final answers = messagesAns
          ?.map(
            (e) => toAnswer(e, status: Status.sent),
          )
          .toList();

      final messages = List.of(answers ?? <MessageModel>[])
        ..addAll(comments ?? <MessageModel>[])
        ..sort(
          (a, b) => b.createdAt!.compareTo(a.createdAt!),
        );

      final newState = state?.copyWith(
        messages: messages,
        syncMessageStatus: SyncMessageStatus.success,
      );
      state = newState;
    } catch (ex) {
      final errorState = state?.copyWith(syncMessageStatus: SyncMessageStatus.error);
      state = errorState;

      rethrow;
    }
  }

  void onSyncMessagesWithLocaleMessage({
    required Feedbacks message,
    required Status status,
    bool isResend = false,
  }) {
    final list = state?.messages;
    final messages = List.of(list ?? <MessageModel>[])
      ..insert(
        0,
        toMessage(
          message,
          status: status,
          isResend: isResend,
        ),
      )
      ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    final newState = state?.copyWith(
      messages: messages,
    );

    state = newState;
  }

  void onSyncMessagesWithoutLocaleMessage({
    required Feedbacks message,
    required bool isResend,
    required bool isReAdd,
    required Status status,
  }) {
    final list = state?.messages;
    final updated = List.of(list ?? <MessageModel>[])
      ..removeWhere(
        (el) => el.id == (isReAdd ? message.reSendKey : message.key),
      );
    final newState = state?.copyWith(
      messages: List.of(updated)
        ..insert(
          0,
          toMessage(
            message,
            status: status,
            isResend: isResend || isReAdd,
          ),
        ),
    );

    state = newState;
  }

  Future<void> sendMessage({
    required Feedbacks message,
    bool isResend = false,
  }) async {
    try {
      onSyncMessagesWithLocaleMessage(message: message, status: Status.sending);

      final body = SendMessage(message: message.comment!);
      final res = await apiClient.sendMessage(body);

      if (res) {
        onSyncMessagesWithoutLocaleMessage(
          message: message,
          status: Status.sent,
          isResend: false,
          isReAdd: false,
        );
      } else {
        onSyncMessagesWithoutLocaleMessage(
          message: message,
          status: Status.error,
          isResend: false,
          isReAdd: false,
        );
      }
    } catch (ex) {
      onSyncMessagesWithoutLocaleMessage(
        message: message,
        status: Status.error,
        isResend: false,
        isReAdd: false,
      );
      rethrow;
    }
  }

  Future<void> onReSendMessage({required Feedbacks body}) async{
    try {
        onSyncMessagesWithoutLocaleMessage(
          message: body,
          status: Status.sending,
          isResend: true,
          isReAdd: false,
      );
      final message = SendMessage(message: body.comment!);
      final res = await apiClient.sendMessage(message);
      if (res) {
        onSyncMessagesWithoutLocaleMessage(
            message: body,
            status: Status.sending,
            isResend: false,
            isReAdd: true,
        );
      } else {
          onSyncMessagesWithoutLocaleMessage(
            message: body,
            status: Status.error,
            isResend: false,
            isReAdd: true,
        );
      }
    } catch (ex) {
        onSyncMessagesWithoutLocaleMessage(
          message: body,
          status: Status.error,
          isResend: false,
          isReAdd: true,
      );
      rethrow;
    }
  }
}
