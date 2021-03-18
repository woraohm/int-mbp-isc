import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'delete_favourite_acct_request.g.dart';

@JsonSerializable()
class DeleteFavouriteAcctRequest extends BaseRequest {
  final String acctName;
  final String acctNo;
  final String bankName;

 

  DeleteFavouriteAcctRequest({
    String reqRefNo,
    this.bankName,
    this.acctNo,
    this.acctName
   
  }) : super(reqRefNo);

  factory DeleteFavouriteAcctRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteFavouriteAcctRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteFavouriteAcctRequestToJson(this);
}
