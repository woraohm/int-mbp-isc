// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transf_order_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransfOrderModelResponse _$TransfOrderModelResponseFromJson(
    Map<String, dynamic> json) {
  return TransfOrderModelResponse(
    dateTime: json['dateTime'] as String,
    to_Acct_Name_En: json['to_Acct_Name_En'] as String,
    to_Acct_Name_Th: json['to_Acct_Name_Th'] as String,
    trace_No: json['trace_No'] as String,
    trnStatus: json['trnStatus'] as String,
  );
}

Map<String, dynamic> _$TransfOrderModelResponseToJson(
        TransfOrderModelResponse instance) =>
    <String, dynamic>{
      'trace_No': instance.trace_No,
      'to_Acct_Name_Th': instance.to_Acct_Name_Th,
      'to_Acct_Name_En': instance.to_Acct_Name_En,
      'dateTime': instance.dateTime,
      'trnStatus': instance.trnStatus,
    };
