// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_favourite_acct_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFavouriteAcctResponse _$AddFavouriteAcctResponseFromJson(
    Map<String, dynamic> json) {
  return AddFavouriteAcctResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['firstName_Th'] as String,
    json['lastName_Th'] as String,
    json['acct_No'] as String,
  );
}

Map<String, dynamic> _$AddFavouriteAcctResponseToJson(
        AddFavouriteAcctResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'firstName_Th': instance.firstName_Th,
      'lastName_Th': instance.lastName_Th,
      'acct_No': instance.acct_No,
    };
