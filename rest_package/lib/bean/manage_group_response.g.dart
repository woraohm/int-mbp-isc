// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageGroupResponse _$ManageGroupResponseFromJson(Map<String, dynamic> json) {
  return ManageGroupResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['listManageGroup'] as List)
        ?.map((e) => e == null
            ? null
            : ManageGroupModelResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['message'] as String,
  )..countUser = json['countUser'] as int;
}

Map<String, dynamic> _$ManageGroupResponseToJson(
        ManageGroupResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'message': instance.message,
      'countUser': instance.countUser,
      'listManageGroup': instance.listManageGroup,
    };
