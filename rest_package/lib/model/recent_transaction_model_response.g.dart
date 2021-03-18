// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_transaction_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentTransactionModelResponse _$RecentTransactionModelResponseFromJson(
    Map<String, dynamic> json) {
  return RecentTransactionModelResponse(
    lkTransferType: json['lkTransferType'] as String,
    lkTransferTypeDes: json['lkTransferTypeDes'] as String,
    trfAcctNo: json['trfAcctNo'] as String,
    amount: (json['amount'] as num)?.toDouble(),
    dateTime: json['dateTime'] as String,
    trfBotBankName: json['trfBotBankName'] as String,
  );
}

Map<String, dynamic> _$RecentTransactionModelResponseToJson(
        RecentTransactionModelResponse instance) =>
    <String, dynamic>{
      'lkTransferType': instance.lkTransferType,
      'lkTransferTypeDes': instance.lkTransferTypeDes,
      'trfAcctNo': instance.trfAcctNo,
      'amount': instance.amount,
      'dateTime': instance.dateTime,
      'trfBotBankName': instance.trfBotBankName,
    };
