// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_acct_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteAcctResponse _$FavouriteAcctResponseFromJson(
    Map<String, dynamic> json) {
  return FavouriteAcctResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['listFavoriteAccount'] as List)
        ?.map((e) => e == null
            ? null
            : FavouriteAcctModelResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FavouriteAcctResponseToJson(
        FavouriteAcctResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'listFavoriteAccount': instance.listFavoriteAccount,
    };
