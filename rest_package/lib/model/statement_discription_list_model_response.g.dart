// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statement_discription_list_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatementDescriptionListModelResponse
    _$StatementDescriptionListModelResponseFromJson(Map<String, dynamic> json) {
  return StatementDescriptionListModelResponse(
    refNo: json['refNo'] as String,
    period: json['period'] as String,
    countOrder: json['countOrder'] as int,
    sumAmountTrnf: (json['sumAmountTrnf'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$StatementDescriptionListModelResponseToJson(
        StatementDescriptionListModelResponse instance) =>
    <String, dynamic>{
      'refNo': instance.refNo,
      'period': instance.period,
      'countOrder': instance.countOrder,
      'sumAmountTrnf': instance.sumAmountTrnf,
    };
