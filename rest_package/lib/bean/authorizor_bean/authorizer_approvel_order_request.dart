import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'authorizer_approvel_order_request.g.dart';

@JsonSerializable()
class AuthorizerApprovelOrderRequest extends BaseRequest {
  final String trace_No;
  final String actionCode;
  final String note;

  AuthorizerApprovelOrderRequest({
    String reqRefNo,
    this.trace_No,
    this.actionCode,
    this.note,
   
  }) : super(reqRefNo);

  factory AuthorizerApprovelOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthorizerApprovelOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizerApprovelOrderRequestToJson(this);
}
