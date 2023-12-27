import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final String access;
  final String refresh;

  LoginResponseModel({
    required this.access,
    required this.refresh,
  });
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

}
