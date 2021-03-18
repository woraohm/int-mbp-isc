// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_group_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageGroupModelResponse _$ManageGroupModelResponseFromJson(
    Map<String, dynamic> json) {
  return ManageGroupModelResponse(
    amount: (json['amount'] as num)?.toDouble(),
    trfAcctNameTh: json['trfAcctNameTh'] as String,
    bankName: json['bankName'] as String,
    trfAcctNameEn: json['trfAcctNameEn'] as String,
    trfAcctNo: json['trfAcctNo'] as String,
  );
}

Map<String, dynamic> _$ManageGroupModelResponseToJson(
        ManageGroupModelResponse instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'trfAcctNameTh': instance.trfAcctNameTh,
      'bankName': instance.bankName,
      'trfAcctNameEn': instance.trfAcctNameEn,
      'trfAcctNo': instance.trfAcctNo,
    };
