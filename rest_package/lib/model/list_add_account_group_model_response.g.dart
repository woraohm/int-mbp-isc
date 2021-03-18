// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_add_account_group_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAddAccountGroupModelResponse _$ListAddAccountGroupModelResponseFromJson(
    Map<String, dynamic> json) {
  return ListAddAccountGroupModelResponse(
    firstName_Th: json['firstName_Th'] as String,
    lastName_Th: json['lastName_Th'] as String,
    accountNo: json['accountNo'] as String,
    bankName: json['bankName'] as String,
  );
}

Map<String, dynamic> _$ListAddAccountGroupModelResponseToJson(
        ListAddAccountGroupModelResponse instance) =>
    <String, dynamic>{
      'firstName_Th': instance.firstName_Th,
      'lastName_Th': instance.lastName_Th,
      'accountNo': instance.accountNo,
      'bankName': instance.bankName,
    };
