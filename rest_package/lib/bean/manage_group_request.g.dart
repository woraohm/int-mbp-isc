// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageGroupRequest _$ManageGroupRequestFromJson(Map<String, dynamic> json) {
  return ManageGroupRequest(
    reqRefNo: json['reqRefNo'] as String,
    groupName: json['groupName'] as String,
  );
}

Map<String, dynamic> _$ManageGroupRequestToJson(ManageGroupRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'groupName': instance.groupName,
    };
