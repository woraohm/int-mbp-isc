import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'add_promptpay_other_request.g.dart';

@JsonSerializable()
class AddPromptpayOtherRequest extends BaseRequest {
  final String prompt_Pay_No;
  final String acctName;

 

  AddPromptpayOtherRequest({
    String reqRefNo,
    this.prompt_Pay_No,
    this.acctName,
   
  }) : super(reqRefNo);

  factory AddPromptpayOtherRequest.fromJson(Map<String, dynamic> json) =>
      _$AddPromptpayOtherRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddPromptpayOtherRequestToJson(this);
}
