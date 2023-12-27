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

OrderBox _$OrderBoxFromJson(Map<String, dynamic> json) => OrderBox(
      boxes: (json['boxes'] as List<dynamic>)
          .map((e) => Boxes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Boxes _$BoxesFromJson(Map<String, dynamic> json) => Boxes(
      id: json['id'] as int?,
      clientFrom: json['clientfrom'] as String?,
      clientTo: json['clientto'] as String?,
      phoneFrom: json['phonefrom'] as String?,
      phoneTo: json['phoneto'] as String?,
      addressFrom: json['addressfrom'] as String?,
      addressTo: json['addressto'] as String?,
      amount: json['amount'] as String?,
      weight: json['weight'] as String?,
      volumeSm: json['volumesm'] as String?,
      delivery: json['delivery'] as String?,
      minSm: json['minsm'] as String?,
      maxSm: json['maxsm'] as String?,
      placeCount: json['placeount'] as int?,
      discount: json['discount'] as String?,
      valuta: json['valuta'] as String?,
      status: json['status'] as String?,
      comment: json['comment'] as String?,
      select: json['select'] as bool?,
      payment: json['payment'] as String?,
      boxImg: json['boximg'] as String?,
      regionFromName: json['regionfrom__name'] as String?,
      regionToName: json['regionto__name'] as String?,
      inputDate: _dateTimeFromJson(json['inputdate'] as String),
      updateDate: _dateTimeFromJson(json['updatedate'] as String),
      user: json['user'] as int?,
    );
