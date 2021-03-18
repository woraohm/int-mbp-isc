// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checker_check_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckerCheckOrderRequest _$CheckerCheckOrderRequestFromJson(
    Map<String, dynamic> json) {
  return CheckerCheckOrderRequest(
    reqRefNo: json['reqRefNo'] as String,
    trace_No: json['trace_No'] as String,
    actionCode: json['actionCode'] as String,
    note: json['note'] as String,
  );
}

Map<String, dynamic> _$CheckerCheckOrderRequestToJson(
        CheckerCheckOrderRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'trace_No': instance.trace_No,
      'actionCode': instance.actionCode,
      'note': instance.note,
    };
