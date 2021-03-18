import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'check_add_acct_other_request.g.dart';

@JsonSerializable()
class CheckAddAcctOtherRequest extends BaseRequest {
  final String acctNo;

 

  CheckAddAcctOtherRequest({
    String reqRefNo,

    this.acctNo,
  }) : super(reqRefNo);

  factory CheckAddAcctOtherRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckAddAcctOtherRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAddAcctOtherRequestToJson(this);
}
