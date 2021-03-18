// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transf_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransfOrderRequest _$TransfOrderRequestFromJson(Map<String, dynamic> json) {
  return TransfOrderRequest(
    reqRefNo: json['reqRefNo'] as String,
    trnStatusCode: json['trnStatusCode'] as String,
  );
}

Map<String, dynamic> _$TransfOrderRequestToJson(TransfOrderRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'trnStatusCode': instance.trnStatusCode,
    };
