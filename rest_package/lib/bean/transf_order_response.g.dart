// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transf_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransfOrderResponse _$TransfOrderResponseFromJson(Map<String, dynamic> json) {
  return TransfOrderResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['listintMbpTxTransLog'] as List)
        ?.map((e) => e == null
            ? null
            : TransfOrderModelResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TransfOrderResponseToJson(
        TransfOrderResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'listintMbpTxTransLog': instance.listintMbpTxTransLog,
    };
