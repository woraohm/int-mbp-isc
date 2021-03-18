import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'check_add_promptpay_other_request.g.dart';

@JsonSerializable()
class CheckAddPromptpayOtherRequest extends BaseRequest {
  final String prompt_Pay_No;

 

  CheckAddPromptpayOtherRequest({
    String reqRefNo,
    this.prompt_Pay_No
   
  }) : super(reqRefNo);

  factory CheckAddPromptpayOtherRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckAddPromptpayOtherRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAddPromptpayOtherRequestToJson(this);
}
