import 'package:json_annotation/json_annotation.dart';


part 'company_user_acct_response.g.dart';

@JsonSerializable()
class CompanyUserAcctResponse {
  final String accountName;

  final String accountNo;
  final String bankName;

  CompanyUserAcctResponse({
    this.accountName,
    this.accountNo,
    this.bankName
  });

   factory CompanyUserAcctResponse.fromJson(Map<String, dynamic> json) => _$CompanyUserAcctResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyUserAcctResponseToJson(this);
}
