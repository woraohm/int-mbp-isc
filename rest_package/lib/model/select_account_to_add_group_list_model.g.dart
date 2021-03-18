// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_account_to_add_group_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectAccountToAddGroupModel _$SelectAccountToAddGroupModelFromJson(
    Map<String, dynamic> json) {
  return SelectAccountToAddGroupModel(
    bank_Name_Recipient: json['bank_Name_Recipient'] as String,
    recipient_account_No: json['recipient_account_No'] as String,
    recipient_account_No_name_En:
        json['recipient_account_No_name_En'] as String,
    recipient_account_No_name_Th:
        json['recipient_account_No_name_Th'] as String,
    transAmount: (json['transAmount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SelectAccountToAddGroupModelToJson(
        SelectAccountToAddGroupModel instance) =>
    <String, dynamic>{
      'bank_Name_Recipient': instance.bank_Name_Recipient,
      'recipient_account_No': instance.recipient_account_No,
      'recipient_account_No_name_Th': instance.recipient_account_No_name_Th,
      'recipient_account_No_name_En': instance.recipient_account_No_name_En,
      'transAmount': instance.transAmount,
    };
