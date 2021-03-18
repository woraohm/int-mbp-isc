import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'check_has_account_request.g.dart';

@JsonSerializable()
class CheckHasAccountRequest extends BaseRequest {
  final String account_No;

 

  CheckHasAccountRequest({
    String reqRefNo,
    this.account_No,
   
  }) : super(reqRefNo);

  factory CheckHasAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckHasAccountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckHasAccountRequestToJson(this);
}
