// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checker_history_detail_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckerHistoryDetailRequest _$CheckerHistoryDetailRequestFromJson(
    Map<String, dynamic> json) {
  return CheckerHistoryDetailRequest(
    reqRefNo: json['reqRefNo'] as String,
    trace_No: json['trace_No'] as String,
  );
}

Map<String, dynamic> _$CheckerHistoryDetailRequestToJson(
        CheckerHistoryDetailRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'trace_No': instance.trace_No,
    };
