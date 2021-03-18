import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'add_favourite_acct_request.g.dart';

@JsonSerializable()
class AddFavouriteAcctRequest extends BaseRequest {
  final String bankName;
  final String acctNo;
  final String acctName;
 

  AddFavouriteAcctRequest({
    String reqRefNo,
    this.bankName,
    this.acctNo,
    this.acctName,
  }) : super(reqRefNo);

  factory AddFavouriteAcctRequest.fromJson(Map<String, dynamic> json) =>
      _$AddFavouriteAcctRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddFavouriteAcctRequestToJson(this);
}
