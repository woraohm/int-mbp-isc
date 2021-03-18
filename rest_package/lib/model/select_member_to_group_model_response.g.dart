// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_member_to_group_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectMemberToGroupModelResponse _$SelectMemberToGroupModelResponseFromJson(
    Map<String, dynamic> json) {
  return SelectMemberToGroupModelResponse(
    acctNo: json['acctNo'] as String,
    acctName: json['acctName'] as String,
    bankName: json['bankName'] as String,
  );
}

Map<String, dynamic> _$SelectMemberToGroupModelResponseToJson(
        SelectMemberToGroupModelResponse instance) =>
    <String, dynamic>{
      'acctNo': instance.acctNo,
      'acctName': instance.acctName,
      'bankName': instance.bankName,
    };
