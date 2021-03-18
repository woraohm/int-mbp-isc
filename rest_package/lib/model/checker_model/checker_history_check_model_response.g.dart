// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checker_history_check_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckerHistoryCheckModelResponse _$CheckerHistoryCheckModelResponseFromJson(
    Map<String, dynamic> json) {
  return CheckerHistoryCheckModelResponse(
    dateTime: json['dateTime'] as String,
    to_Acct_Name_En: json['to_Acct_Name_En'] as String,
    to_Acct_Name_Th: json['to_Acct_Name_Th'] as String,
    trace_No: json['trace_No'] as String,
    transfer_Type: json['transfer_Type'] as String,
    transfer_Type_Description: json['transfer_Type_Description'] as String,
  );
}

Map<String, dynamic> _$CheckerHistoryCheckModelResponseToJson(
        CheckerHistoryCheckModelResponse instance) =>
    <String, dynamic>{
      'trace_No': instance.trace_No,
      'to_Acct_Name_Th': instance.to_Acct_Name_Th,
      'to_Acct_Name_En': instance.to_Acct_Name_En,
      'dateTime': instance.dateTime,
      'transfer_Type': instance.transfer_Type,
      'transfer_Type_Description': instance.transfer_Type_Description,
    };
