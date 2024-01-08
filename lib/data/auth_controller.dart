// ignore_for_file: constant_identifier_names
// ignore: depend_on_referenced_packages
import 'dart:convert';
import 'package:state_notifier/state_notifier.dart';
import 'response.dart';
import 'service/preferences.dart';

class UserState {
  final String username;
  final String phone;
  final String email;
  final int regionId;
  final String authToken;
  final String refreshToken;

  UserState({
    required this.username,
    required this.phone,
    required this.email,
    required this.regionId,
    required this.authToken,
    required this.refreshToken,
  });

  UserState copyWith({
    String? username,
    String? phone,
    String? email,
    int? regionId,
    String? authToken,
    String? refreshToken,
  }) {
    return UserState(
      username: username ?? this.username,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      regionId: regionId ?? this.regionId,
      authToken: authToken ?? this.authToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}

class AuthController extends StateNotifier<UserState?> {
  static const _UserName = 'user_name';
  static const _Phone = 'phone';
  static const _Email = 'email';
  static const _RegionId = 'region_id';
  static const _AuthToken = 'auth_token';
  static const _RefreshToken = 'refresh_token';

  final AppPrefsService _service;

  bool get isAuthorized => state != null;

  String? get authToken => state?.authToken;

  String? get refreshToken => state?.refreshToken;

  AuthController(this._service, super.state);

  static UserState? initialState(AppPrefsService service) {
    String username = '';
    String phone = '';
    String email = '';
    int regionId = 0;
    String? authToken;
    String? refreshToken;

    try {
      authToken = service.getString(_AuthToken);
      refreshToken = service.getString(_RefreshToken);
      username = service.getString(_UserName) ?? '';
      phone = service.getString(_Phone) ?? '';
      email = service.getString(_Email) ?? '';
      regionId = service.getInt(_RegionId) ?? 0;
    } catch (e) {
      //ignored
    }

    if (authToken != null && refreshToken != null) {
      return UserState(
        username: username,
        phone: phone,
        email: email,
        regionId: regionId,
        authToken: authToken,
        refreshToken: refreshToken,
      );
    }

    return null;
  }

  Future<void> onSignedIn(LoginResponse response) async {
    final newState = UserState(
      username: response.user.name,
      phone: response.user.phone,
      email: response.user.email,
      regionId: response.address.regionId,
      authToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
    state = newState;

    try {
      await _service.setString(_AuthToken, newState.authToken);
      await _service.setString(_RefreshToken, newState.refreshToken);
      await _service.setString(_UserName, newState.username);
      await _service.setString(_Phone, newState.phone);
      await _service.setString(_Email, newState.email);
      await _service.setInt(_RegionId, newState.regionId);
    } catch (e) {
      //ignored
    }
  }

  Future<void> updateAccessToken(String accessToken) async{
    final oldState = state;
    assert(oldState != null);

    if (oldState == null) {
      throw ArgumentError("[updateUser] can't be called in unauthorized state");
    }

    final newState = oldState.copyWith(
      authToken: accessToken,
    );

    try {
      await _service.setString(_AuthToken, newState.authToken);
    } catch (e) {
      //ignored
    }
  }

  void updateUser(LoginResponse response) {
    final oldState = state;
    assert(oldState != null);

    if (oldState == null) {
      throw ArgumentError("[updateUser] can't be called in unauthorized state");
    }

    final newState = oldState.copyWith(
      username: response.user.username,
      phone: response.user.phone,
      email: response.user.email,
      regionId: response.address.regionId,
      authToken: response.accessToken,
      refreshToken: response.refreshToken,
    );

    try {
      /*await*/ _service.setString(_AuthToken, newState.authToken);
      /*await*/ _service.setString(_RefreshToken, newState.refreshToken);
      /*await*/ _service.setString(_UserName, newState.username);
      /*await*/ _service.setString(_Phone, newState.phone);
      /*await*/ _service.setString(_Email, newState.email);
      /*await*/ _service.setInt(_RegionId, newState.regionId);
    } catch (e) {
      //ignored
    }
  }

  Future<void> signOut() async {
    state = null;

    try {
      await _service.remove(_AuthToken);
      await _service.remove(_RefreshToken);
      await _service.remove(_UserName);
      await _service.remove(_Phone);
      await _service.remove(_Email);
      await _service.remove(_RegionId);
    } catch (e) {
      //ignored
    }
  }
}
