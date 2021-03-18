// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transf_order_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransfOrderDetailResponse _$TransfOrderDetailResponseFromJson(
    Map<String, dynamic> json) {
  return TransfOrderDetailResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['traceNo'] as String,
    json['dateTime'] as String,
    json['sender_Account_No'] as String,
    json['bank_Name_Sender'] as String,
    json['lk_acct_type_name'] as String,
    json['bank_Name_Recipient'] as String,
    json['recipient_account_No'] as String,
    json['recipient_account_No_name_Th'] as String,
    json['recipient_account_No_name_En'] as String,
    json['note'] as String,
    (json['fee'] as num)?.toDouble(),
    (json['amount'] as num)?.toDouble(),
    json['trnStatus'] as String,
  );
}

Map<String, dynamic> _$TransfOrderDetailResponseToJson(
        TransfOrderDetailResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'traceNo': instance.traceNo,
      'dateTime': instance.dateTime,
      'sender_Account_No': instance.sender_Account_No,
      'lk_acct_type_name': instance.lk_acct_type_name,
      'bank_Name_Sender': instance.bank_Name_Sender,
      'bank_Name_Recipient': instance.bank_Name_Recipient,
      'recipient_account_No': instance.recipient_account_No,
      'recipient_account_No_name_Th': instance.recipient_account_No_name_Th,
      'recipient_account_No_name_En': instance.recipient_account_No_name_En,
      'note': instance.note,
      'fee': instance.fee,
      'amount': instance.amount,
      'trnStatus': instance.trnStatus,
    };
