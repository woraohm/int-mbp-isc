// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_other_acct_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteOtherAcctRequest _$DeleteOtherAcctRequestFromJson(
    Map<String, dynamic> json) {
  return DeleteOtherAcctRequest(
    reqRefNo: json['reqRefNo'] as String,
    acct_Name: json['acct_Name'] as String,
    acct_No: json['acct_No'] as String,
    bankName: json['bankName'] as String,
  );
}

Map<String, dynamic> _$DeleteOtherAcctRequestToJson(
        DeleteOtherAcctRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'bankName': instance.bankName,
      'acct_No': instance.acct_No,
      'acct_Name': instance.acct_Name,
    };
