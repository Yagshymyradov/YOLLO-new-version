// ignore_for_file: constant_identifier_names
// ignore: depend_on_referenced_packages
import 'package:state_notifier/state_notifier.dart';
import 'package:yollo/data/response.dart';

import 'service/preferences.dart';

class UserState {
  final String username;
  final String authToken;

  UserState({
    required this.username,
    required this.authToken,
  });
}

class AuthController extends StateNotifier<UserState?> {
  static const _UserName = 'user_name';
  static const _AuthToken = 'auth_token';

  final AppPrefsService _service;

  String? get authToken => state?.authToken;

  AuthController(this._service, super.state);

  static UserState? initialState(AppPrefsService service) {
    String username = '';
    String? authToken;

    try {
      authToken = service.getString(_AuthToken);
      username = service.getString(_UserName) ?? '';
    } catch (e) {
      //ignored
    }

    if (authToken != null) {
      return UserState(
        username: username,
        authToken: authToken,
      );
    }

    return null;
  }

  Future<void> onSignedIn(LoginResponse response) async {
    final newState = UserState(
      username: response.user.username,
      authToken: response.accessToken,
    );
    state = newState;

    try {
      await _service.setString(_AuthToken, newState.authToken);
      await _service.setString(_UserName, newState.username);
    } catch (e) {
      //ignored
    }
  }

  Future<void> signOut() async {
    state = null;

    try {
      await _service.remove(_AuthToken);
      await _service.remove(_UserName);
    } catch (e) {
      //ignored
    }
  }
}
