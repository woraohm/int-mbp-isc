// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorizer_check_transf_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizerCheckTransfResponse _$AuthorizerCheckTransfResponseFromJson(
    Map<String, dynamic> json) {
  return AuthorizerCheckTransfResponse(
    respCode: json['respCode'] as String,
    respDesc: json['respDesc'] as String,
    reqRefNo: json['reqRefNo'] as String,
    respRefNo: json['respRefNo'] as String,
    lk_acct_type_name: json['lk_acct_type_name'] as String,
    traceNo: json['traceNo'] as String,
    dateTime: json['dateTime'] as String,
    sender_Account_No: json['sender_Account_No'] as String,
    bank_Name_Sender: json['bank_Name_Sender'] as String,
    bank_Name_Recipient: json['bank_Name_Recipient'] as String,
    recipient_account_No: json['recipient_account_No'] as String,
    recipient_account_No_name_Th:
        json['recipient_account_No_name_Th'] as String,
    recipient_account_No_name_En:
        json['recipient_account_No_name_En'] as String,
    note: json['note'] as String,
    fee: (json['fee'] as num)?.toDouble(),
    amount: (json['amount'] as num)?.toDouble(),
    trnStatus: json['trnStatus'] as String,
  );
}

Map<String, dynamic> _$AuthorizerCheckTransfResponseToJson(
        AuthorizerCheckTransfResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'traceNo': instance.traceNo,
      'dateTime': instance.dateTime,
      'sender_Account_No': instance.sender_Account_No,
      'bank_Name_Sender': instance.bank_Name_Sender,
      'bank_Name_Recipient': instance.bank_Name_Recipient,
      'recipient_account_No': instance.recipient_account_No,
      'recipient_account_No_name_Th': instance.recipient_account_No_name_Th,
      'recipient_account_No_name_En': instance.recipient_account_No_name_En,
      'note': instance.note,
      'fee': instance.fee,
      'amount': instance.amount,
      'trnStatus': instance.trnStatus,
      'lk_acct_type_name': instance.lk_acct_type_name,
    };
