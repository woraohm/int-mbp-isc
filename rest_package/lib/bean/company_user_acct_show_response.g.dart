// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_user_acct_show_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyUserAcctShowResponse _$CompanyUserAcctShowResponseFromJson(
    Map<String, dynamic> json) {
  return CompanyUserAcctShowResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['userAccount'] as List)
        ?.map((e) => e == null
            ? null
            : CompanyUserAcctResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CompanyUserAcctShowResponseToJson(
        CompanyUserAcctShowResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'userAccount': instance.userAccount,
    };
