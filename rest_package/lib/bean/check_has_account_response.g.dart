// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_has_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckHasAccountResponse _$CheckHasAccountResponseFromJson(
    Map<String, dynamic> json) {
  return CheckHasAccountResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['accountNo'] as String,
    json['accountName'] as String,
    json['bankName'] as String,
    json['accountType'] as String,
    (json['availableBalance'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CheckHasAccountResponseToJson(
        CheckHasAccountResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'accountNo': instance.accountNo,
      'accountName': instance.accountName,
      'bankName': instance.bankName,
      'accountType': instance.accountType,
      'availableBalance': instance.availableBalance,
    };
