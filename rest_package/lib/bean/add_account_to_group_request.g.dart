// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_account_to_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAccountToGroupRequest _$AddAccountToGroupRequestFromJson(
    Map<String, dynamic> json) {
  return AddAccountToGroupRequest(
    reqRefNo: json['reqRefNo'] as String,
    groupName: json['groupName'] as String,
    listAddAccountGroupRequest: (json['listAddAccountGroupRequest'] as List)
        ?.map((e) => e == null
            ? null
            : SelectAccountToAddGroupModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AddAccountToGroupRequestToJson(
        AddAccountToGroupRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'groupName': instance.groupName,
      'listAddAccountGroupRequest': instance.listAddAccountGroupRequest,
    };
