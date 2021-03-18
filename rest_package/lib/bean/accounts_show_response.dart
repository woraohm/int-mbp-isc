import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/accounts_response.dart';
import 'package:rest_package/bean/base_response.dart';

part 'accounts_show_response.g.dart';

@JsonSerializable()
class AccountsShowResponse extends BaseResponse{
  List<AccountsResponse> accounts;

  AccountsShowResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.accounts,

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory AccountsShowResponse.fromJson(Map<String, dynamic> json) => _$AccountsShowResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountsShowResponseToJson(this);

}