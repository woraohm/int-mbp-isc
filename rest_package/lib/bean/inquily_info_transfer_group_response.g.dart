// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inquily_info_transfer_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InquilyInfoTransferGroupResponse _$InquilyInfoTransferGroupResponseFromJson(
    Map<String, dynamic> json) {
  return InquilyInfoTransferGroupResponse(
    respCode: json['respCode'] as String,
    respDesc: json['respDesc'] as String,
    reqRefNo: json['reqRefNo'] as String,
    respRefNo: json['respRefNo'] as String,
    listResponse: (json['listResponse'] as List)
        ?.map((e) => e == null
            ? null
            : InquilyInfoTransferGroupModelResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$InquilyInfoTransferGroupResponseToJson(
        InquilyInfoTransferGroupResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'listResponse': instance.listResponse,
    };
