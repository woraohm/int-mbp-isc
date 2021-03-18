// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graph_show_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphShowResponse _$GraphShowResponseFromJson(Map<String, dynamic> json) {
  return GraphShowResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['accountList'] as List)
        ?.map((e) => e == null
            ? null
            : GraphResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GraphShowResponseToJson(GraphShowResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'accountList': instance.accountList,
    };
