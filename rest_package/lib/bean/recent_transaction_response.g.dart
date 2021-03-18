// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentTransactionResponse _$RecentTransactionResponseFromJson(
    Map<String, dynamic> json) {
  return RecentTransactionResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['listRecentTrn'] as List)
        ?.map((e) => e == null
            ? null
            : RecentTransactionModelResponse.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RecentTransactionResponseToJson(
        RecentTransactionResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'listRecentTrn': instance.listRecentTrn,
    };
