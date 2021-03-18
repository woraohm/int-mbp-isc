import 'package:json_annotation/json_annotation.dart';


part 'accounts_response.g.dart';

@JsonSerializable()
class AccountsResponse {
  final double ostdBalance;
  final double availableBalance;
  final String acctNo;
  final String accType;
  final String accName;
  final String bankName;

  AccountsResponse({
    this.ostdBalance,
    this.availableBalance,
    this.acctNo,
    this.accType,
    this.accName,
    this.bankName
  });

   factory AccountsResponse.fromJson(Map<String, dynamic> json) => _$AccountsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountsResponseToJson(this);
}
