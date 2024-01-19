// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yollo_chat_ui/chat_ui.dart';

class ChatModel {
  final List<Feedbacks>? feedbacks;

  ChatModel({required this.feedbacks});

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      feedbacks: map['feedbacks'] != null
          ? List<Feedbacks>.from(
        (map['feedbacks'] as List<dynamic>).map<Feedbacks?>(
              (x) => Feedbacks.fromMap(x as Map<String, dynamic>),
        ),
      )
          : null,
    );
  }

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChatModel(feedbacks: $feedbacks)';
}

class Feedbacks {
  final int? id;
  final DateTime? inputDate;
  final String? comment;
  final String? answer;
  final DateTime? answerDate;
  final int? user;
  final int? ansUser;
  final String? key;
  final String? ansKey;
  final String? reSendKey;

  Feedbacks({
    this.id,
    this.reSendKey,
    this.key,
    this.inputDate,
    this.comment,
    this.answer,
    this.answerDate,
    this.user,
    this.ansKey,
    this.ansUser,
  });

  factory Feedbacks.fromMap(Map<String, dynamic> map) {
    return Feedbacks(
      id: map['id'] != null ? map['id'] as int : null,
      inputDate: map['inputdate'] != null
          ? DateTime.tryParse(map['inputdate'] as String)
          : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      answer: map['answer'] != null ? map['answer'] as String : null,
      answerDate: map['answerdate'] != null
          ? DateTime.tryParse(map['answerdate'] as String)
          : null,
      user: map['user'] != null ? map['user'] as int : null,
      ansUser: map['ansuser'] != null ? map['ansuser'] as int : null,
      key: UniqueKey().toString(),
      ansKey: UniqueKey().toString(),
    );
  }

  factory Feedbacks.fromJson(String source) =>
      Feedbacks.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Feedbacks(id: $id, inputDate: $inputDate, comment: $comment, answer: $answer, answerDate: $answerDate, user: $user, ansUser: $ansUser, key: $key, reSendKey: $reSendKey)';
  }
}

class SendMessage {
  final String message;

  SendMessage({required this.message});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
    };
  }
}

class Model {
  final String name;
  final String id;
  Model({
    required this.name,
    required this.id,
  });

  Model copyWith({
    String? name,
    String? id,
  }) {
    return Model(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      name: map['name'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) =>
      Model.fromMap(json.decode(source) as Map<String, dynamic>);
}

String getHMDateTime(DateTime? time) {
  if (time == null) return '';
  final hour = time.hour < 10 ? ('0${time.hour}') : time.hour;
  final minute = time.minute < 10 ? ('0${time.minute}') : time.minute;
  return '$hour:$minute';
}

String chatDate(DateTime? time) {
  if (time == null) return '';
  final month = time.month < 10 ? ('0${time.month}') : time.month;
  final day = time.day < 10 ? ('0${time.day}') : time.day;
  return '$day-$month-${time.year}';
}

MessageModel toMessage(
    Feedbacks msg, {
      Status? status,
      bool isResend = false,
    }) {
  String timeText;
  if (msg.inputDate != null) {
    final dateTime = msg.inputDate;
    timeText = getHMDateTime(dateTime);
  } else {
    timeText = getHMDateTime(DateTime.now());
  }
  return TextMessageModel(
    updatedAt: msg.id,
    text: msg.comment ?? (msg.answer ?? ''),
    author: toSender(msg.user),
    id: isResend
        ? (msg.reSendKey ?? UniqueKey().toString())
        : msg.key ?? UniqueKey().toString(),
    showStatus: true,
    isOwner: msg.comment != null || msg.comment != "",
    createdAt: msg.inputDate == null
        ? DateTime.now().millisecondsSinceEpoch
        : msg.inputDate!.millisecondsSinceEpoch,
    status: status,
    receivedTime: MessageReceivedTime(
      timeText: timeText,
      timeDate: msg.inputDate == null ? DateTime.now() : null,
    ),
  );
}

MessageModel toComment(
    Feedbacks msg, {
      Status? status,
      bool isResend = false,
    }) {
  String timeText;
  if (msg.inputDate != null) {
    final dateTime = msg.inputDate;
    timeText = getHMDateTime(dateTime);
  } else {
    timeText = getHMDateTime(DateTime.now());
  }
  return TextMessageModel(
    updatedAt: msg.id,
    text: msg.comment ?? '',
    author: toSender(msg.user),
    id: isResend
        ? (msg.reSendKey ?? UniqueKey().toString())
        : msg.key ?? UniqueKey().toString(),
    showStatus: true,
    isOwner: true,
    createdAt: msg.inputDate == null
        ? DateTime.now().millisecondsSinceEpoch
        : msg.inputDate!.millisecondsSinceEpoch,
    status: status,
    receivedTime: MessageReceivedTime(
      timeText: timeText,
      timeDate: msg.inputDate == null ? DateTime.now() : null,
    ),
  );
}

MessageModel toAnswer(
    Feedbacks msg, {
      Status? status,
      bool isResend = false,
    }) {
  String timeText;
  if (msg.inputDate != null) {
    final dateTime = msg.inputDate;
    timeText = getHMDateTime(dateTime);
  } else {
    timeText = getHMDateTime(DateTime.now());
  }
  return TextMessageModel(
    updatedAt: msg.id,
    text: msg.answer ?? '',
    author: toSender(msg.user),
    id: msg.ansKey ?? UniqueKey().toString(),
    showStatus: true,
    isOwner: false,
    createdAt: msg.inputDate == null
        ? DateTime.now().millisecondsSinceEpoch
        : msg.inputDate!.millisecondsSinceEpoch,
    status: status,
    receivedTime: MessageReceivedTime(
      timeText: timeText,
      timeDate: msg.inputDate == null ? DateTime.now() : null,
    ),
  );
}

UserModel toSender(int? id) {
  return UserModel(
    isBase64UrlOfAvatar: false,
    id: id.toString(),
  );
}
