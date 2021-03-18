// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_add_acct_other_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckAddAcctOtherResponse _$CheckAddAcctOtherResponseFromJson(
    Map<String, dynamic> json) {
  return CheckAddAcctOtherResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['acctNo'] as String,
    json['nameEn'] as String,
    json['nameTh'] as String,
  );
}

Map<String, dynamic> _$CheckAddAcctOtherResponseToJson(
        CheckAddAcctOtherResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'acctNo': instance.acctNo,
      'nameTh': instance.nameTh,
      'nameEn': instance.nameEn,
    };
