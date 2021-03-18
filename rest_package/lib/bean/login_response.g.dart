// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['token'] as String,
    json['name_th'] as String,
    json['lastname_th'] as String,
    json['email'] as String,
    json['theme'] as String,
    json['name_Th_Company'] as String,
    json['mobile_No'] as String,
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'token': instance.token,
      'name_th': instance.name_th,
      'lastname_th': instance.lastname_th,
      'email': instance.email,
      'theme': instance.theme,
      'name_Th_Company': instance.name_Th_Company,
      'mobile_No': instance.mobile_No,
    };
