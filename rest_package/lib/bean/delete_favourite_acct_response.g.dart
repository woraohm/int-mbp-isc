// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_favourite_acct_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteFavouriteAcctResponse _$DeleteFavouriteAcctResponseFromJson(
    Map<String, dynamic> json) {
  return DeleteFavouriteAcctResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$DeleteFavouriteAcctResponseToJson(
        DeleteFavouriteAcctResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'message': instance.message,
    };
