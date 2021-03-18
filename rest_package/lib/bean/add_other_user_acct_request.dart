import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'add_other_user_acct_request.g.dart';

@JsonSerializable()
class AddOtherUserAcctRequest extends BaseRequest {
  final String bank_Name;
  final String acct_Name;
  final String acct_No;
 

  AddOtherUserAcctRequest({
    String reqRefNo,
    this.bank_Name,
    this.acct_Name,
    this.acct_No,
  }) : super(reqRefNo);

  factory AddOtherUserAcctRequest.fromJson(Map<String, dynamic> json) =>
      _$AddOtherUserAcctRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddOtherUserAcctRequestToJson(this);
}
