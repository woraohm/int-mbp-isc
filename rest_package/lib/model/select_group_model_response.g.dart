// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_group_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectGroupModelResponse _$SelectGroupModelResponseFromJson(
    Map<String, dynamic> json) {
  return SelectGroupModelResponse(
    nameGroup: json['nameGroup'] as String,
    countRecipient: json['countRecipient'] as int,
    totalAmount: (json['totalAmount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SelectGroupModelResponseToJson(
        SelectGroupModelResponse instance) =>
    <String, dynamic>{
      'nameGroup': instance.nameGroup,
      'countRecipient': instance.countRecipient,
      'totalAmount': instance.totalAmount,
    };
