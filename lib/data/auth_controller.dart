// ignore_for_file: constant_identifier_names
// ignore: depend_on_referenced_packages
import 'package:state_notifier/state_notifier.dart';

import 'response.dart';
import 'service/preferences.dart';

class UserState {
  final String username;
  final String phone;
  final String email;
  final int regionId;
  final String address;
  final String regionName;
  final String regionHi;
  final String authToken;
  final String refreshToken;

  UserState({
    required this.username,
    required this.phone,
    required this.email,
    required this.regionId,
    required this.authToken,
    required this.refreshToken,
    required this.address,
    required this.regionName,
    required this.regionHi,
  });

  UserState copyWith({
    String? username,
    String? phone,
    String? email,
    int? regionId,
    String? authToken,
    String? refreshToken,
    String? address,
    String? regionName,
    String? regionHi,
  }) {
    return UserState(
      username: username ?? this.username,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      regionId: regionId ?? this.regionId,
      address: address ?? this.address,
      regionName: regionName ?? this.regionName,
      regionHi: regionHi ?? this.regionHi,
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
  static const _Address = 'address';
  static const _RegionName = 'region_name';
  static const _RegionHi = 'region_hi';
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
    String address = '';
    String regionName = '';
    String regionHi = '';
    int regionId = 0;
    String? authToken;
    String? refreshToken;

    try {
      refreshToken = service.getString(_RefreshToken);
      authToken = service.getString(_AuthToken);
      username = service.getString(_UserName) ?? '';
      phone = service.getString(_Phone) ?? '';
      email = service.getString(_Email) ?? '';
      regionId = service.getInt(_RegionId) ?? 0;
      address = service.getString(_Address) ?? '';
      regionName = service.getString(_RegionName) ?? '';
      regionHi = service.getString(_RegionHi) ?? '';
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
        address: address,
        regionName: regionName,
        regionHi: regionHi,
      );
    }

    return null;
  }

  void onSignedIn(LoginResponse response) {
    final newState = UserState(
      username: response.user.name,
      phone: response.user.phone,
      email: response.user.email,
      regionId: response.address.regionId,
      authToken: response.accessToken ?? '',
      refreshToken: response.refreshToken ?? '',
      address: response.address.address,
      regionName: response.address.regionName,
      regionHi: response.address.regionHi,
    );
    state = newState;

    try {
      _service.setString(_AuthToken, newState.authToken);
      _service.setString(_RefreshToken, newState.refreshToken);
      _service.setString(_UserName, newState.username);
      _service.setString(_Phone, newState.phone);
      _service.setString(_Email, newState.email);
      _service.setInt(_RegionId, newState.regionId);
      _service.setString(_Address, newState.address);
      _service.setString(_RegionName, newState.regionName);
      _service.setString(_RegionHi, newState.regionHi);
    } catch (e) {
      //ignored
    }
  }

  Future<void> updateAccessToken(String accessToken) async {
    final oldState = state;
    assert(oldState != null);

    if (oldState == null) {
      throw ArgumentError("[updateUser] can't be called in unauthorized state");
    }

    final newState = oldState.copyWith(
      authToken: accessToken,
    );

    state = newState;

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
      username: response.user.name,
      phone: response.user.phone,
      email: response.user.email,
      regionId: response.address.regionId,
      regionName: response.address.regionName,
      regionHi: response.address.regionHi,
      address: response.address.address,
    );

    state = newState;

    try {
      _service.setString(_UserName, newState.username);
      _service.setString(_Phone, newState.phone);
      _service.setString(_Email, newState.email);
      _service.setInt(_RegionId, newState.regionId);
      _service.setString(_Address, newState.address);
      _service.setString(_RegionName, newState.regionName);
      _service.setString(_RegionHi, newState.regionHi);
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
      await _service.remove(_Address);
      await _service.remove(_RegionName);
      await _service.remove(_RegionHi);
    } catch (e) {
      //ignored
    }
  }
}
