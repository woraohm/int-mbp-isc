// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteGroupResponse _$DeleteGroupResponseFromJson(Map<String, dynamic> json) {
  return DeleteGroupResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
  );
}

Map<String, dynamic> _$DeleteGroupResponseToJson(
        DeleteGroupResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
    };
