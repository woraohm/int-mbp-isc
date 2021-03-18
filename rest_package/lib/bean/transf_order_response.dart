import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';

import 'package:rest_package/model/transf_order_model_response.dart';

part 'transf_order_response.g.dart';

@JsonSerializable()
class TransfOrderResponse extends BaseResponse{
  List<TransfOrderModelResponse>listintMbpTxTransLog;

  TransfOrderResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.listintMbpTxTransLog,

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory TransfOrderResponse.fromJson(Map<String, dynamic> json) => _$TransfOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransfOrderResponseToJson(this);

}