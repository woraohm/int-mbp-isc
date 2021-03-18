import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'delete_other_acct_request.g.dart';

@JsonSerializable()
class DeleteOtherAcctRequest extends BaseRequest {
  final String bankName;
  final String acct_No;
  final String acct_Name;

 

  DeleteOtherAcctRequest({
    String reqRefNo,
    this.acct_Name,
    this.acct_No,
    this.bankName
   
  }) : super(reqRefNo);

  factory DeleteOtherAcctRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteOtherAcctRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteOtherAcctRequestToJson(this);
}
