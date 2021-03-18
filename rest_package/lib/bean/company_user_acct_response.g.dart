// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_user_acct_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyUserAcctResponse _$CompanyUserAcctResponseFromJson(
    Map<String, dynamic> json) {
  return CompanyUserAcctResponse(
    accountName: json['accountName'] as String,
    accountNo: json['accountNo'] as String,
    bankName: json['bankName'] as String,
  );
}

Map<String, dynamic> _$CompanyUserAcctResponseToJson(
        CompanyUserAcctResponse instance) =>
    <String, dynamic>{
      'accountName': instance.accountName,
      'accountNo': instance.accountNo,
      'bankName': instance.bankName,
    };
