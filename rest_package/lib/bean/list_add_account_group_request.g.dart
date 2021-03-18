// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_add_account_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAddAccountGroupRequest _$ListAddAccountGroupRequestFromJson(
    Map<String, dynamic> json) {
  return ListAddAccountGroupRequest(
    reqRefNo: json['reqRefNo'] as String,
    nameGroup: json['nameGroup'] as String,
  );
}

Map<String, dynamic> _$ListAddAccountGroupRequestToJson(
        ListAddAccountGroupRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'nameGroup': instance.nameGroup,
    };
