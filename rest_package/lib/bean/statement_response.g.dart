// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statement_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatementResponse _$StatementResponseFromJson(Map<String, dynamic> json) {
  return StatementResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['statementList'] as List)
        ?.map((e) => e == null
            ? null
            : StatementListModelResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['descriptionStatementList'] as List)
        ?.map((e) => e == null
            ? null
            : StatementDescriptionListModelResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$StatementResponseToJson(StatementResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'statementList': instance.statementList,
      'descriptionStatementList': instance.descriptionStatementList,
    };
