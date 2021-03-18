import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'authorizer_list_order_request.g.dart';

@JsonSerializable()
class AuthorizerListOrderRequest extends BaseRequest {

 

  AuthorizerListOrderRequest({
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory AuthorizerListOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthorizerListOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizerListOrderRequestToJson(this);
}
