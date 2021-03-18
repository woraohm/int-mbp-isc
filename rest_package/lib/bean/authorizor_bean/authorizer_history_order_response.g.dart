// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorizer_history_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizerHistoryOrderResponse _$AuthorizerHistoryOrderResponseFromJson(
    Map<String, dynamic> json) {
  return AuthorizerHistoryOrderResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['checkerListOrder'] as List)
        ?.map((e) => e == null
            ? null
            : AuthorizerHistoryOrderModelResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AuthorizerHistoryOrderResponseToJson(
        AuthorizerHistoryOrderResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'checkerListOrder': instance.checkerListOrder,
    };
