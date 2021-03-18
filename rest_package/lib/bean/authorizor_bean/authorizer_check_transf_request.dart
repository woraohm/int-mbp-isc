import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'authorizer_check_transf_request.g.dart';

@JsonSerializable()
class AuthorizerCheckTransfRequest extends BaseRequest {
  final String traceNo;
 

  AuthorizerCheckTransfRequest({
    String reqRefNo,
    this.traceNo,

   
  }) : super(reqRefNo);

  factory AuthorizerCheckTransfRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthorizerCheckTransfRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizerCheckTransfRequestToJson(this);
}
