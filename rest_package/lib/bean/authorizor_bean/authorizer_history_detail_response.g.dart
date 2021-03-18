// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorizer_history_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizerHistoryDetailResponse _$AuthorizerHistoryDetailResponseFromJson(
    Map<String, dynamic> json) {
  return AuthorizerHistoryDetailResponse(
    respCode: json['respCode'] as String,
    respDesc: json['respDesc'] as String,
    reqRefNo: json['reqRefNo'] as String,
    respRefNo: json['respRefNo'] as String,
    traceNo: json['traceNo'] as String,
    sender_Account_No: json['sender_Account_No'] as String,
    dateTime: json['dateTime'] as String,
    bank_Name_Sender_Th: json['bank_Name_Sender_Th'] as String,
    bank_Name_Sender_En: json['bank_Name_Sender_En'] as String,
    bank_Name_Recipient: json['bank_Name_Recipient'] as String,
    recipient_account_No: json['recipient_account_No'] as String,
    recipient_account_No_name_Th:
        json['recipient_account_No_name_Th'] as String,
    recipient_account_No_name_En:
        json['recipient_account_No_name_En'] as String,
    amount: (json['amount'] as num)?.toDouble(),
    note: json['note'] as String,
    fee: (json['fee'] as num)?.toDouble(),
    name_Check: json['name_Check'] as String,
    sender_Account_Type: json['sender_Account_Type'] as String,
    trnStatus: json['trnStatus'] as String,
  );
}

Map<String, dynamic> _$AuthorizerHistoryDetailResponseToJson(
        AuthorizerHistoryDetailResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'traceNo': instance.traceNo,
      'sender_Account_No': instance.sender_Account_No,
      'dateTime': instance.dateTime,
      'bank_Name_Sender_Th': instance.bank_Name_Sender_Th,
      'bank_Name_Sender_En': instance.bank_Name_Sender_En,
      'bank_Name_Recipient': instance.bank_Name_Recipient,
      'recipient_account_No': instance.recipient_account_No,
      'recipient_account_No_name_Th': instance.recipient_account_No_name_Th,
      'recipient_account_No_name_En': instance.recipient_account_No_name_En,
      'amount': instance.amount,
      'note': instance.note,
      'fee': instance.fee,
      'name_Check': instance.name_Check,
      'sender_Account_Type': instance.sender_Account_Type,
      'trnStatus': instance.trnStatus,
    };
