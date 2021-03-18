// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeGroupRequest _$ChangeGroupRequestFromJson(Map<String, dynamic> json) {
  return ChangeGroupRequest(
    reqRefNo: json['reqRefNo'] as String,
    groupNameOld: json['groupNameOld'] as String,
    groupNameNew: json['groupNameNew'] as String,
  );
}

Map<String, dynamic> _$ChangeGroupRequestToJson(ChangeGroupRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'groupNameOld': instance.groupNameOld,
      'groupNameNew': instance.groupNameNew,
    };
