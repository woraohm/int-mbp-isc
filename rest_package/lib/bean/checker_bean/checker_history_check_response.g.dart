// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checker_history_check_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckerHistoryCheckResponse _$CheckerHistoryCheckResponseFromJson(
    Map<String, dynamic> json) {
  return CheckerHistoryCheckResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['checkerListOrder'] as List)
        ?.map((e) => e == null
            ? null
            : CheckerHistoryCheckModelResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CheckerHistoryCheckResponseToJson(
        CheckerHistoryCheckResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'checkerListOrder': instance.checkerListOrder,
    };
