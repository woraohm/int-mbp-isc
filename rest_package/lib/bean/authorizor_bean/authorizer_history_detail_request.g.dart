// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorizer_history_detail_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizerHistoryDetailRequest _$AuthorizerHistoryDetailRequestFromJson(
    Map<String, dynamic> json) {
  return AuthorizerHistoryDetailRequest(
    reqRefNo: json['reqRefNo'] as String,
    trace_No: json['trace_No'] as String,
  );
}

Map<String, dynamic> _$AuthorizerHistoryDetailRequestToJson(
        AuthorizerHistoryDetailRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'trace_No': instance.trace_No,
    };
