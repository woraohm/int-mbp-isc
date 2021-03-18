import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';

import 'package:rest_package/model/checker_model/checker_list_order_model_response.dart';

part 'checker_list_order_response.g.dart';

@JsonSerializable()
class CheckerListOrderResponse extends BaseResponse{
  List<CheckerListOrderModelResponse>checkerListOrder;

  CheckerListOrderResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.checkerListOrder,

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory CheckerListOrderResponse.fromJson(Map<String, dynamic> json) => _$CheckerListOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckerListOrderResponseToJson(this);

}