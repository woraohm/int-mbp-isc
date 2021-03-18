// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorizer_check_transf_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizerCheckTransfRequest _$AuthorizerCheckTransfRequestFromJson(
    Map<String, dynamic> json) {
  return AuthorizerCheckTransfRequest(
    reqRefNo: json['reqRefNo'] as String,
    traceNo: json['traceNo'] as String,
  );
}

Map<String, dynamic> _$AuthorizerCheckTransfRequestToJson(
        AuthorizerCheckTransfRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'traceNo': instance.traceNo,
    };
