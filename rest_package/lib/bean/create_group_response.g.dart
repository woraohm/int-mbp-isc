// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGroupResponse _$CreateGroupResponseFromJson(Map<String, dynamic> json) {
  return CreateGroupResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$CreateGroupResponseToJson(
        CreateGroupResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'message': instance.message,
    };
