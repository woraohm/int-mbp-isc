// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_member_to_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectMemberToGroupResponse _$SelectMemberToGroupResponseFromJson(
    Map<String, dynamic> json) {
  return SelectMemberToGroupResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['listAcctNo'] as List)
        ?.map((e) => e == null
            ? null
            : SelectMemberToGroupModelResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SelectMemberToGroupResponseToJson(
        SelectMemberToGroupResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'listAcctNo': instance.listAcctNo,
    };
