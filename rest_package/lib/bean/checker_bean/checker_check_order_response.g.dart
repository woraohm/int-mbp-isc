// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checker_check_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckerCheckOrderResponse _$CheckerCheckOrderResponseFromJson(
    Map<String, dynamic> json) {
  return CheckerCheckOrderResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['traceNo'] as String,
    json['dateTime'] as String,
    json['sender_Account_No'] as String,
    json['bank_Name_Sender_Th'] as String,
    json['bank_Name_Sender_En'] as String,
    json['sender_Account_Type'] as String,
    json['bank_Name_Recipient'] as String,
    json['recipient_account_No'] as String,
    json['recipient_account_No_name_Th'] as String,
    json['recipient_account_No_name_En'] as String,
    json['note'] as String,
    (json['fee'] as num)?.toDouble(),
    (json['amount'] as num)?.toDouble(),
    json['trnStatus'] as String,
    json['message'] as String,
    json['name_Check'] as String,
  );
}

Map<String, dynamic> _$CheckerCheckOrderResponseToJson(
        CheckerCheckOrderResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'traceNo': instance.traceNo,
      'dateTime': instance.dateTime,
      'sender_Account_No': instance.sender_Account_No,
      'bank_Name_Sender_Th': instance.bank_Name_Sender_Th,
      'bank_Name_Sender_En': instance.bank_Name_Sender_En,
      'sender_Account_Type': instance.sender_Account_Type,
      'bank_Name_Recipient': instance.bank_Name_Recipient,
      'recipient_account_No': instance.recipient_account_No,
      'recipient_account_No_name_Th': instance.recipient_account_No_name_Th,
      'recipient_account_No_name_En': instance.recipient_account_No_name_En,
      'note': instance.note,
      'fee': instance.fee,
      'amount': instance.amount,
      'trnStatus': instance.trnStatus,
      'message': instance.message,
      'name_Check': instance.name_Check,
    };
