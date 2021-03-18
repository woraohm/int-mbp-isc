// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_has_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckHasAccountRequest _$CheckHasAccountRequestFromJson(
    Map<String, dynamic> json) {
  return CheckHasAccountRequest(
    reqRefNo: json['reqRefNo'] as String,
    account_No: json['account_No'] as String,
  );
}

Map<String, dynamic> _$CheckHasAccountRequestToJson(
        CheckHasAccountRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'account_No': instance.account_No,
    };
