// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorizer_approvel_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizerApprovelOrderRequest _$AuthorizerApprovelOrderRequestFromJson(
    Map<String, dynamic> json) {
  return AuthorizerApprovelOrderRequest(
    reqRefNo: json['reqRefNo'] as String,
    trace_No: json['trace_No'] as String,
    actionCode: json['actionCode'] as String,
    note: json['note'] as String,
  );
}

Map<String, dynamic> _$AuthorizerApprovelOrderRequestToJson(
        AuthorizerApprovelOrderRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'trace_No': instance.trace_No,
      'actionCode': instance.actionCode,
      'note': instance.note,
    };
