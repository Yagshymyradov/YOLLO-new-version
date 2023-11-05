// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      refreshToken: json['refresh'] as String,
      accessToken: json['access'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
    );

User _$UserFromJson(Map<String, dynamic> json) => User(
      username: json['username'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      address: json['address'] as String,
      regionName: json['region_name'] as String,
      regionId: json['region_id'] as int,
      regionHi: json['region_hi'] as String,
    );

Regions _$RegionsFromJson(Map<String, dynamic> json) => Regions(
      count: json['count'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => RegionResults.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

RegionResults _$RegionResultsFromJson(Map<String, dynamic> json) =>
    RegionResults(
      id: json['id'] as int,
      name: json['name'] as String,
      tarif: json['tarif'] as String,
      hiRegion: json['hi_region'] as String,
    );
