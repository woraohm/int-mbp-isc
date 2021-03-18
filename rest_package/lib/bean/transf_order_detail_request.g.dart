// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transf_order_detail_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransfOrderDetailRequest _$TransfOrderDetailRequestFromJson(
    Map<String, dynamic> json) {
  return TransfOrderDetailRequest(
    reqRefNo: json['reqRefNo'] as String,
    traceNo: json['traceNo'] as String,
  );
}

Map<String, dynamic> _$TransfOrderDetailRequestToJson(
        TransfOrderDetailRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'traceNo': instance.traceNo,
    };
