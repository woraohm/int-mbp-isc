// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_member_to_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectMemberToGroupRequest _$SelectMemberToGroupRequestFromJson(
    Map<String, dynamic> json) {
  return SelectMemberToGroupRequest(
    reqRefNo: json['reqRefNo'] as String,
    groupName: json['groupName'] as String,
  );
}

Map<String, dynamic> _$SelectMemberToGroupRequestToJson(
        SelectMemberToGroupRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'groupName': instance.groupName,
    };
