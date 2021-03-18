// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checker_list_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckerListOrderResponse _$CheckerListOrderResponseFromJson(
    Map<String, dynamic> json) {
  return CheckerListOrderResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['checkerListOrder'] as List)
        ?.map((e) => e == null
            ? null
            : CheckerListOrderModelResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CheckerListOrderResponseToJson(
        CheckerListOrderResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'checkerListOrder': instance.checkerListOrder,
    };
