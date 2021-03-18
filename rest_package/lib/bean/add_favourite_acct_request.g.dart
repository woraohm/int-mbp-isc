// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_favourite_acct_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFavouriteAcctRequest _$AddFavouriteAcctRequestFromJson(
    Map<String, dynamic> json) {
  return AddFavouriteAcctRequest(
    reqRefNo: json['reqRefNo'] as String,
    bankName: json['bankName'] as String,
    acctNo: json['acctNo'] as String,
    acctName: json['acctName'] as String,
  );
}

Map<String, dynamic> _$AddFavouriteAcctRequestToJson(
        AddFavouriteAcctRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'bankName': instance.bankName,
      'acctNo': instance.acctNo,
      'acctName': instance.acctName,
    };
