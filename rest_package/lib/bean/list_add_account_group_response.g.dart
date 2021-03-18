// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_add_account_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAddAccountGroupResponse _$ListAddAccountGroupResponseFromJson(
    Map<String, dynamic> json) {
  return ListAddAccountGroupResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['listAcctsToAddFavAcct'] as List)
        ?.map((e) => e == null
            ? null
            : ListAddAccountGroupModelResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListAddAccountGroupResponseToJson(
        ListAddAccountGroupResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'listAcctsToAddFavAcct': instance.listAcctsToAddFavAcct,
    };
