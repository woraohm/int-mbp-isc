// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statement_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatementRequest _$StatementRequestFromJson(Map<String, dynamic> json) {
  return StatementRequest(
    reqRefNo: json['reqRefNo'] as String,
    acctNo: json['acctNo'] as String,
    dateEnd: json['dateEnd'] as String,
    dateStart: json['dateStart'] as String,
  );
}

Map<String, dynamic> _$StatementRequestToJson(StatementRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'dateStart': instance.dateStart,
      'dateEnd': instance.dateEnd,
      'acctNo': instance.acctNo,
    };
