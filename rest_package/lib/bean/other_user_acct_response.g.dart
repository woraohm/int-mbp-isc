// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_user_acct_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherUserAcctResponse _$OtherUserAcctResponseFromJson(
    Map<String, dynamic> json) {
  return OtherUserAcctResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['otherUserAcctList'] as List)
        ?.map((e) => e == null
            ? null
            : OtherUserAcctModelResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['otherUserAcctPromptpay'] as List)
        ?.map((e) => e == null
            ? null
            : OtherUserAcctModelResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OtherUserAcctResponseToJson(
        OtherUserAcctResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'otherUserAcctList': instance.otherUserAcctList,
      'otherUserAcctPromptpay': instance.otherUserAcctPromptpay,
    };
