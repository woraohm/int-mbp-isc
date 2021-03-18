// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_other_user_acct_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddOtherUserAcctResponse _$AddOtherUserAcctResponseFromJson(
    Map<String, dynamic> json) {
  return AddOtherUserAcctResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$AddOtherUserAcctResponseToJson(
        AddOtherUserAcctResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
    };
