// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGroupRequest _$CreateGroupRequestFromJson(Map<String, dynamic> json) {
  return CreateGroupRequest(
    reqRefNo: json['reqRefNo'] as String,
    groupName: json['groupName'] as String,
  );
}

Map<String, dynamic> _$CreateGroupRequestToJson(CreateGroupRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'groupName': instance.groupName,
    };
