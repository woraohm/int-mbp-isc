// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graph_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphResponse _$GraphResponseFromJson(Map<String, dynamic> json) {
  return GraphResponse(
    ostdBalance: (json['ostdBalance'] as num)?.toDouble(),
    accType: json['accType'] as String,
  );
}

Map<String, dynamic> _$GraphResponseToJson(GraphResponse instance) =>
    <String, dynamic>{
      'ostdBalance': instance.ostdBalance,
      'accType': instance.accType,
    };
