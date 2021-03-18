import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'authorizer_history_detail_request.g.dart';

@JsonSerializable()
class AuthorizerHistoryDetailRequest extends BaseRequest {
  final String trace_No;
 

  AuthorizerHistoryDetailRequest({
    String reqRefNo,
    this.trace_No,
   
  }) : super(reqRefNo);

  factory AuthorizerHistoryDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthorizerHistoryDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizerHistoryDetailRequestToJson(this);
}
