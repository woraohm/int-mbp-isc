import 'package:json_annotation/json_annotation.dart';


part 'other_user_acct_model_response.g.dart';

@JsonSerializable()
class OtherUserAcctModelResponse {
  final String acct_No;
  final String acct_Name;
  final String bank_Name;
  final String promptpay;
  

  OtherUserAcctModelResponse({
    this.acct_No,
    this.acct_Name,
    this.bank_Name,
    this.promptpay
    
  });

   factory OtherUserAcctModelResponse.fromJson(Map<String, dynamic> json) => _$OtherUserAcctModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OtherUserAcctModelResponseToJson(this);
}
