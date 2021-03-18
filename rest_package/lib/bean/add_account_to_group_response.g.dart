// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_account_to_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAccountToGroupResponse _$AddAccountToGroupResponseFromJson(
    Map<String, dynamic> json) {
  return AddAccountToGroupResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$AddAccountToGroupResponseToJson(
        AddAccountToGroupResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
    };
