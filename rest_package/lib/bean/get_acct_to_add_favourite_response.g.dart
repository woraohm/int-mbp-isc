// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_acct_to_add_favourite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAcctToAddFavouriteResponse _$GetAcctToAddFavouriteResponseFromJson(
    Map<String, dynamic> json) {
  return GetAcctToAddFavouriteResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['listAcctCompany'] as List)
        ?.map((e) => e == null
            ? null
            : GetAcctToAddFavouriteModelResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
    (json['listAcctOther'] as List)
        ?.map((e) => e == null
            ? null
            : GetAcctToAddFavouriteModelResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetAcctToAddFavouriteResponseToJson(
        GetAcctToAddFavouriteResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'listAcctCompany': instance.listAcctCompany,
      'listAcctOther': instance.listAcctOther,
    };
