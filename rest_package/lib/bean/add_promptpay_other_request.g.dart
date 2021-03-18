// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_promptpay_other_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPromptpayOtherRequest _$AddPromptpayOtherRequestFromJson(
    Map<String, dynamic> json) {
  return AddPromptpayOtherRequest(
    reqRefNo: json['reqRefNo'] as String,
    prompt_Pay_No: json['prompt_Pay_No'] as String,
    acctName: json['acctName'] as String,
  );
}

Map<String, dynamic> _$AddPromptpayOtherRequestToJson(
        AddPromptpayOtherRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'prompt_Pay_No': instance.prompt_Pay_No,
      'acctName': instance.acctName,
    };
