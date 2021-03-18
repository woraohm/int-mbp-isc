// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_promptpay_other_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPromptpayOtherResponse _$AddPromptpayOtherResponseFromJson(
    Map<String, dynamic> json) {
  return AddPromptpayOtherResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$AddPromptpayOtherResponseToJson(
        AddPromptpayOtherResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'message': instance.message,
    };
