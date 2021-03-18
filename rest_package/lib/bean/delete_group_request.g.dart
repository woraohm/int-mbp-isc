// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteGroupRequest _$DeleteGroupRequestFromJson(Map<String, dynamic> json) {
  return DeleteGroupRequest(
    reqRefNo: json['reqRefNo'] as String,
    groupName: json['groupName'] as String,
  );
}

Map<String, dynamic> _$DeleteGroupRequestToJson(DeleteGroupRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'groupName': instance.groupName,
    };
