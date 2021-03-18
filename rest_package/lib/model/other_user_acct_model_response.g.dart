// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_user_acct_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherUserAcctModelResponse _$OtherUserAcctModelResponseFromJson(
    Map<String, dynamic> json) {
  return OtherUserAcctModelResponse(
    acct_No: json['acct_No'] as String,
    acct_Name: json['acct_Name'] as String,
    bank_Name: json['bank_Name'] as String,
    promptpay: json['promptpay'] as String,
  );
}

Map<String, dynamic> _$OtherUserAcctModelResponseToJson(
        OtherUserAcctModelResponse instance) =>
    <String, dynamic>{
      'acct_No': instance.acct_No,
      'acct_Name': instance.acct_Name,
      'bank_Name': instance.bank_Name,
      'promptpay': instance.promptpay,
    };
