import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

double _priceFromJson(num value) => value.toDouble();

bool _intBoolFromJson(int value) => value == 1;

DateTime _dateTimeFromJson(String value) => DateTime.parse(value);

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
class RegionResults with EquatableMixin {
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

@JsonSerializable()
class OrderBox {
  final List<Boxes> boxes;

  OrderBox({required this.boxes});

  factory OrderBox.fromJson(Map<String, dynamic> json) => _$OrderBoxFromJson(json);
}

@JsonSerializable()
class Boxes {
  final int? id;
  @JsonKey(name: 'clientfrom')
  final String? clientFrom;
  @JsonKey(name: 'clientto')
  final String? clientTo;
  @JsonKey(name: 'phonefrom')
  final String? phoneFrom;
  @JsonKey(name: 'phoneto')
  final String? phoneTo;
  @JsonKey(name: 'addressfrom')
  final String? addressFrom;
  @JsonKey(name: 'addressto')
  final String? addressTo;
  final String? amount;
  final String? weight;
  @JsonKey(name: 'volumesm')
  final String? volumeSm;
  final String? delivery;
  @JsonKey(name: 'minsm')
  final String? minSm;
  @JsonKey(name: 'maxsm')
  final String? maxSm;
  @JsonKey(name: 'placeount')
  final int? placeCount;
  final String? discount;
  final String? valuta;
  final String? status;
  final String? comment;
  final bool? select;
  final String? payment;
  @JsonKey(name: 'boximg')
  final String? boxImg;
  @JsonKey(name: 'regionfrom__name')
  final String? regionFromName;
  @JsonKey(name: 'regionto__name')
  final String? regionToName;
  @JsonKey(name: 'inputdate', fromJson: _dateTimeFromJson)
  final DateTime? inputDate;
  @JsonKey(name: 'updatedate', fromJson: _dateTimeFromJson)
  final DateTime? updateDate;
  final int? user;

  Boxes({
    required this.id,
    required this.clientFrom,
    required this.clientTo,
    required this.phoneFrom,
    required this.phoneTo,
    required this.addressFrom,
    required this.addressTo,
    required this.amount,
    required this.weight,
    required this.volumeSm,
    required this.delivery,
    required this.minSm,
    required this.maxSm,
    required this.placeCount,
    required this.discount,
    required this.valuta,
    required this.status,
    required this.comment,
    required this.select,
    required this.payment,
    required this.boxImg,
    required this.regionFromName,
    required this.regionToName,
    required this.inputDate,
    required this.updateDate,
    required this.user,
  });

  factory Boxes.fromJson(Map<String, dynamic> json) => _$BoxesFromJson(json);
}
