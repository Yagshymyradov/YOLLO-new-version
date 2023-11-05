import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserState {
  final String username;
  final String password;
  final String authToken;

  UserState({
    required this.username,
    required this.password,
    required this.authToken,
  });
}

// class AuthController extends StateNotifier<UserState?>{
//   static const
// }
