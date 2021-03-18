// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_favourite_acct_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteFavouriteAcctRequest _$DeleteFavouriteAcctRequestFromJson(
    Map<String, dynamic> json) {
  return DeleteFavouriteAcctRequest(
    reqRefNo: json['reqRefNo'] as String,
    bankName: json['bankName'] as String,
    acctNo: json['acctNo'] as String,
    acctName: json['acctName'] as String,
  );
}

Map<String, dynamic> _$DeleteFavouriteAcctRequestToJson(
        DeleteFavouriteAcctRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'acctName': instance.acctName,
      'acctNo': instance.acctNo,
      'bankName': instance.bankName,
    };
