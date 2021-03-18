// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorizer_list_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizerListOrderResponse _$AuthorizerListOrderResponseFromJson(
    Map<String, dynamic> json) {
  return AuthorizerListOrderResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['checkerListOrder'] as List)
        ?.map((e) => e == null
            ? null
            : AuthorizerListOrderModelResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AuthorizerListOrderResponseToJson(
        AuthorizerListOrderResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'checkerListOrder': instance.checkerListOrder,
    };
