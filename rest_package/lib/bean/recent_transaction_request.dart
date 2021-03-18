import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'recent_transaction_request.g.dart';

@JsonSerializable()
class RecentTransactionRequest extends BaseRequest {

 

  RecentTransactionRequest({
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory RecentTransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$RecentTransactionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RecentTransactionRequestToJson(this);
}
