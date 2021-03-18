import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';
import 'package:rest_package/model/authorizer_model/authorizer_history_order_model_response.dart';



part 'authorizer_history_order_response.g.dart';

@JsonSerializable()
class AuthorizerHistoryOrderResponse extends BaseResponse{
  List<AuthorizerHistoryOrderModelResponse> checkerListOrder;

  AuthorizerHistoryOrderResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.checkerListOrder,

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory AuthorizerHistoryOrderResponse.fromJson(Map<String, dynamic> json) => _$AuthorizerHistoryOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizerHistoryOrderResponseToJson(this);

}