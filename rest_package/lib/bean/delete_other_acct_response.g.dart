// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_other_acct_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteOtherAcctResponse _$DeleteOtherAcctResponseFromJson(
    Map<String, dynamic> json) {
  return DeleteOtherAcctResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$DeleteOtherAcctResponseToJson(
        DeleteOtherAcctResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
    };
