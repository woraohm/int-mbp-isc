// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statement_list_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatementListModelResponse _$StatementListModelResponseFromJson(
    Map<String, dynamic> json) {
  return StatementListModelResponse(
    dateTime: json['dateTime'] as String,
    description: json['description'] as String,
    traceNo: json['traceNo'] as String,
    availBalAmt: (json['availBalAmt'] as num)?.toDouble(),
    ledgerBalAmt: (json['ledgerBalAmt'] as num)?.toDouble(),
    frBankName: json['frBankName'] as String,
    frAcctNo: json['frAcctNo'] as String,
    frAcctNameTh: json['frAcctNameTh'] as String,
    frAcctNameEn: json['frAcctNameEn'] as String,
    amount: (json['amount'] as num)?.toDouble(),
    destBankName: json['destBankName'] as String,
    destAcctNo: json['destAcctNo'] as String,
    destAcctNameTh: json['destAcctNameTh'] as String,
    destAcctNameEn: json['destAcctNameEn'] as String,
  );
}

Map<String, dynamic> _$StatementListModelResponseToJson(
        StatementListModelResponse instance) =>
    <String, dynamic>{
      'dateTime': instance.dateTime,
      'description': instance.description,
      'traceNo': instance.traceNo,
      'availBalAmt': instance.availBalAmt,
      'ledgerBalAmt': instance.ledgerBalAmt,
      'frBankName': instance.frBankName,
      'frAcctNo': instance.frAcctNo,
      'frAcctNameTh': instance.frAcctNameTh,
      'frAcctNameEn': instance.frAcctNameEn,
      'amount': instance.amount,
      'destBankName': instance.destBankName,
      'destAcctNo': instance.destAcctNo,
      'destAcctNameTh': instance.destAcctNameTh,
      'destAcctNameEn': instance.destAcctNameEn,
    };
