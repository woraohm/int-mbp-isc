// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inquily_info_transfer_group_model_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InquilyInfoTransferGroupModelRequest
    _$InquilyInfoTransferGroupModelRequestFromJson(Map<String, dynamic> json) {
  return InquilyInfoTransferGroupModelRequest(
    sender_Account_No: json['sender_Account_No'] as String,
    sender_Account_No_name_En: json['sender_Account_No_name_En'] as String,
    sender_Account_No_name_Th: json['sender_Account_No_name_Th'] as String,
    bank_Name_Sender: json['bank_Name_Sender'] as String,
    bank_Name_Recipient: json['bank_Name_Recipient'] as String,
    recipient_account_No: json['recipient_account_No'] as String,
    recipient_account_No_name_Th:
        json['recipient_account_No_name_Th'] as String,
    recipient_account_No_name_En:
        json['recipient_account_No_name_En'] as String,
    transAmount: (json['transAmount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$InquilyInfoTransferGroupModelRequestToJson(
        InquilyInfoTransferGroupModelRequest instance) =>
    <String, dynamic>{
      'sender_Account_No': instance.sender_Account_No,
      'sender_Account_No_name_En': instance.sender_Account_No_name_En,
      'sender_Account_No_name_Th': instance.sender_Account_No_name_Th,
      'bank_Name_Sender': instance.bank_Name_Sender,
      'bank_Name_Recipient': instance.bank_Name_Recipient,
      'recipient_account_No': instance.recipient_account_No,
      'recipient_account_No_name_Th': instance.recipient_account_No_name_Th,
      'recipient_account_No_name_En': instance.recipient_account_No_name_En,
      'transAmount': instance.transAmount,
    };
