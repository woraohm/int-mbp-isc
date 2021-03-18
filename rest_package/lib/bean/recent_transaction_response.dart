import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';

import 'package:rest_package/model/recent_transaction_model_response.dart';

part 'recent_transaction_response.g.dart';

@JsonSerializable()
class RecentTransactionResponse extends BaseResponse{
  List<RecentTransactionModelResponse> listRecentTrn;

  RecentTransactionResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.listRecentTrn,

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory RecentTransactionResponse.fromJson(Map<String, dynamic> json) => _$RecentTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecentTransactionResponseToJson(this);

}