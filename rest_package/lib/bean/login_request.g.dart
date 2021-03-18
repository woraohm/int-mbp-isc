// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return LoginRequest(
    reqRefNo: json['reqRefNo'] as String,
    companyCode: json['companyCode'] as int,
    userCode: json['userCode'] as String,
    userPassword: json['userPassword'] as String,
  );
}

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'companyCode': instance.companyCode,
      'userCode': instance.userCode,
      'userPassword': instance.userPassword,
    };
