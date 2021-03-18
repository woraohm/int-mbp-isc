import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest extends BaseRequest {
  final int companyCode;
  final String userCode;
  final String userPassword;
 

  LoginRequest({
    String reqRefNo,
    this.companyCode,
    this.userCode,
    this.userPassword,
  }) : super(reqRefNo);

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
