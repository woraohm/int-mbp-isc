import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';
import 'package:rest_package/bean/company_user_acct_response.dart';

part 'company_user_acct_show_response.g.dart';

@JsonSerializable()
class CompanyUserAcctShowResponse extends BaseResponse{
  List<CompanyUserAcctResponse> userAccount;

  CompanyUserAcctShowResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.userAccount,

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory CompanyUserAcctShowResponse.fromJson(Map<String, dynamic> json) => _$CompanyUserAcctShowResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyUserAcctShowResponseToJson(this);

}