import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'checker_list_order_request.g.dart';

@JsonSerializable()
class CheckerListOrderRequest extends BaseRequest {

 

  CheckerListOrderRequest({
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory CheckerListOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckerListOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckerListOrderRequestToJson(this);
}
