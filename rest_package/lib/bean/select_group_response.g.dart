// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectGroupResponse _$SelectGroupResponseFromJson(Map<String, dynamic> json) {
  return SelectGroupResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['listGroup'] as List)
        ?.map((e) => e == null
            ? null
            : SelectGroupModelResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['lenghtList'] as int,
  );
}

Map<String, dynamic> _$SelectGroupResponseToJson(
        SelectGroupResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'listGroup': instance.listGroup,
      'lenghtList': instance.lenghtList,
    };
