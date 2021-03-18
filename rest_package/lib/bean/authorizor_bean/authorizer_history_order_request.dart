import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'authorizer_history_order_request.g.dart';

@JsonSerializable()
class AuthorizerHistoryOrderRequest extends BaseRequest {

 

  AuthorizerHistoryOrderRequest({
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory AuthorizerHistoryOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthorizerHistoryOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizerHistoryOrderRequestToJson(this);
}
