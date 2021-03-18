// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_add_promptpay_other_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckAddPromptpayOtherResponse _$CheckAddPromptpayOtherResponseFromJson(
    Map<String, dynamic> json) {
  return CheckAddPromptpayOtherResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['prompt_Pay_No'] as String,
    json['acctName'] as String,
  );
}

Map<String, dynamic> _$CheckAddPromptpayOtherResponseToJson(
        CheckAddPromptpayOtherResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'prompt_Pay_No': instance.prompt_Pay_No,
      'acctName': instance.acctName,
    };
