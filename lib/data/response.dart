import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'refresh')
  final String refreshToken;
  @JsonKey(name: 'access')
  final String accessToken;
  final User user;
  final Address address;

  LoginResponse({
    required this.refreshToken,
    required this.accessToken,
    required this.user,
    required this.address,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
}

@JsonSerializable()
class User {
  final String username;
  final String name;
  final String email;
  final String phone;

  User({
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class Address {
  final String address;
  final String regionName;
  final int regionId;
  final String regionHi;

  Address({
    required this.address,
    required this.regionName,
    required this.regionId,
    required this.regionHi,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}

@JsonSerializable()
class Regions {
  final int count;
  final List<RegionResults> results;

  Regions({
    required this.count,
    required this.results,
  });
  factory Regions.fromJson(Map<String, dynamic> json) => _$RegionsFromJson(json);
}

@JsonSerializable()
class RegionResults with EquatableMixin{
  final int id;
  final String name;
  final String tarif;
  final String hiRegion;

  RegionResults({
    required this.id,
    required this.name,
    required this.tarif,
    required this.hiRegion,
  });
  factory RegionResults.fromJson(Map<String, dynamic> json) => _$RegionResultsFromJson(json);

  @override
  List<Object?> get props => [id, name, tarif, hiRegion];
}
