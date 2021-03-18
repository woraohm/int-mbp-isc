// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inquily_info_transfer_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InquilyInfoTransferGroupRequest _$InquilyInfoTransferGroupRequestFromJson(
    Map<String, dynamic> json) {
  return InquilyInfoTransferGroupRequest(
    reqRefNo: json['reqRefNo'] as String,
    listRequest: (json['listRequest'] as List)
        ?.map((e) => e == null
            ? null
            : InquilyInfoTransferGroupModelRequest.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$InquilyInfoTransferGroupRequestToJson(
        InquilyInfoTransferGroupRequest instance) =>
    <String, dynamic>{
      'reqRefNo': instance.reqRefNo,
      'listRequest': instance.listRequest,
    };
