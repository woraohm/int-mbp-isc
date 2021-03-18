// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeGroupResponse _$ChangeGroupResponseFromJson(Map<String, dynamic> json) {
  return ChangeGroupResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['groupName'] as String,
  );
}

Map<String, dynamic> _$ChangeGroupResponseToJson(
        ChangeGroupResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'groupName': instance.groupName,
    };
