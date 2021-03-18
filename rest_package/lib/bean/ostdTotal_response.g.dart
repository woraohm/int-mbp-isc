// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ostdTotal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OSTDTotalResponse _$OSTDTotalResponseFromJson(Map<String, dynamic> json) {
  return OSTDTotalResponse(
    json['respCode'] as String,
    json['respDesc'] as String,
    json['reqRefNo'] as String,
    json['respRefNo'] as String,
    (json['sumOstdBalance'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OSTDTotalResponseToJson(OSTDTotalResponse instance) =>
    <String, dynamic>{
      'respCode': instance.respCode,
      'respDesc': instance.respDesc,
      'reqRefNo': instance.reqRefNo,
      'respRefNo': instance.respRefNo,
      'sumOstdBalance': instance.sumOstdBalance,
    };
