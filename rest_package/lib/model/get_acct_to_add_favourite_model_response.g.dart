// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_acct_to_add_favourite_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAcctToAddFavouriteModelResponse _$GetAcctToAddFavouriteModelResponseFromJson(
    Map<String, dynamic> json) {
  return GetAcctToAddFavouriteModelResponse(
    acctName: json['acctName'] as String,
    acctNo: json['acctNo'] as String,
    bankName: json['bankName'] as String,
  );
}

Map<String, dynamic> _$GetAcctToAddFavouriteModelResponseToJson(
        GetAcctToAddFavouriteModelResponse instance) =>
    <String, dynamic>{
      'acctName': instance.acctName,
      'acctNo': instance.acctNo,
      'bankName': instance.bankName,
    };
