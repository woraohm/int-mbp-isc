// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountsResponse _$AccountsResponseFromJson(Map<String, dynamic> json) {
  return AccountsResponse(
    ostdBalance: (json['ostdBalance'] as num)?.toDouble(),
    availableBalance: (json['availableBalance'] as num)?.toDouble(),
    acctNo: json['acctNo'] as String,
    accType: json['accType'] as String,
    accName: json['accName'] as String,
    bankName: json['bankName'] as String,
  );
}

Map<String, dynamic> _$AccountsResponseToJson(AccountsResponse instance) =>
    <String, dynamic>{
      'ostdBalance': instance.ostdBalance,
      'availableBalance': instance.availableBalance,
      'acctNo': instance.acctNo,
      'accType': instance.accType,
      'accName': instance.accName,
      'bankName': instance.bankName,
    };
