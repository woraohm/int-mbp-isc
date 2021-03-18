import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';
import 'package:rest_package/model/authorizer_model/authorizer_list_order_model_response.dart';


part 'authorizer_list_order_response.g.dart';

@JsonSerializable()
class AuthorizerListOrderResponse extends BaseResponse{
  List<AuthorizerListOrderModelResponse>checkerListOrder;
  
  AuthorizerListOrderResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.checkerListOrder,

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory AuthorizerListOrderResponse.fromJson(Map<String, dynamic> json) => _$AuthorizerListOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizerListOrderResponseToJson(this);

}