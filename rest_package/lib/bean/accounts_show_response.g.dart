// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_show_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountsShowResponse _$AccountsShowResponseFromJson(Map<String, dynamic> json) {
  return AccountsShowResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['accounts'] as List)
        ?.map((e) => e == null
            ? null
            : AccountsResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AccountsShowResponseToJson(
        AccountsShowResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'accounts': instance.accounts,
    };
