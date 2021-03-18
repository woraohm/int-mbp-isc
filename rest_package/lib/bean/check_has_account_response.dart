import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'check_has_account_response.g.dart';

@JsonSerializable()
class CheckHasAccountResponse extends BaseResponse{

  final String accountNo;
  final String accountName;
  final String bankName;
  final String accountType;
  final double availableBalance;
 
  
  

  CheckHasAccountResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
      this.accountNo,
      this.accountName,
      this.bankName,
      this.accountType,
      this.availableBalance,
     ) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory CheckHasAccountResponse.fromJson(Map<String, dynamic> json) => _$CheckHasAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckHasAccountResponseToJson(this);

}