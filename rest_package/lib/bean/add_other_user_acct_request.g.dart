// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_other_user_acct_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddOtherUserAcctRequest _$AddOtherUserAcctRequestFromJson(
    Map<String, dynamic> json) {
  return AddOtherUserAcctRequest(
    reqRefNo: json['reqRefNo'] as String,
    bank_Name: json['bank_Name'] as String,
    acct_Name: json['acct_Name'] as String,
    acct_No: json['acct_No'] as String,
  );
}

Map<String, dynamic> _$AddOtherUserAcctRequestToJson(
        AddOtherUserAcctRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'bank_Name': instance.bank_Name,
      'acct_Name': instance.acct_Name,
      'acct_No': instance.acct_No,
    };
