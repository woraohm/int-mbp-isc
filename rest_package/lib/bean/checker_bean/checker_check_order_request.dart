import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'checker_check_order_request.g.dart';

@JsonSerializable()
class CheckerCheckOrderRequest extends BaseRequest {
  final String trace_No;
  final String actionCode;
  final String note;

  CheckerCheckOrderRequest({
    String reqRefNo,
    this.trace_No,
    this.actionCode,
    this.note,
   
  }) : super(reqRefNo);

  factory CheckerCheckOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckerCheckOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckerCheckOrderRequestToJson(this);
}
