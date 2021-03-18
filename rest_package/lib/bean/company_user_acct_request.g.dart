// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_user_acct_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyUserAcctRequest _$CompanyUserAcctRequestFromJson(
    Map<String, dynamic> json) {
  return CompanyUserAcctRequest(
    reqRefNo: json['reqRefNo'] as String,
    accountSender: json['accountSender'] as String,
  );
}

Map<String, dynamic> _$CompanyUserAcctRequestToJson(
        CompanyUserAcctRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'accountSender': instance.accountSender,
    };
