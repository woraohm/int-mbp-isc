// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_acct_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteAcctModelResponse _$FavouriteAcctModelResponseFromJson(
    Map<String, dynamic> json) {
  return FavouriteAcctModelResponse(
    acctName: json['acctName'] as String,
    acctNo: json['acctNo'] as String,
    bankName: json['bankName'] as String,
  );
}

Map<String, dynamic> _$FavouriteAcctModelResponseToJson(
        FavouriteAcctModelResponse instance) =>
    <String, dynamic>{
      'acctName': instance.acctName,
      'acctNo': instance.acctNo,
      'bankName': instance.bankName,
    };
