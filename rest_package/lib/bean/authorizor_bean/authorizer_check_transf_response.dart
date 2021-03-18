import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'authorizer_check_transf_response.g.dart';

@JsonSerializable()
class AuthorizerCheckTransfResponse extends BaseResponse{

  String traceNo;
  String dateTime;
  String sender_Account_No;
  String bank_Name_Sender;
  String bank_Name_Recipient;
  String recipient_account_No;
  String recipient_account_No_name_Th;
  String recipient_account_No_name_En;
  String note;
  double fee;
  double amount;
  String trnStatus;
  String lk_acct_type_name;
 
  

  
  

  AuthorizerCheckTransfResponse({
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
      this.lk_acct_type_name,
      this.traceNo,
      this.dateTime,
      this.sender_Account_No,
      this.bank_Name_Sender,
      this.bank_Name_Recipient,
      this.recipient_account_No,
      this.recipient_account_No_name_Th,
      this.recipient_account_No_name_En,
      this.note,
      this.fee,
      this.amount,
      this.trnStatus,
      
      
  }) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory AuthorizerCheckTransfResponse.fromJson(Map<String, dynamic> json) => _$AuthorizerCheckTransfResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizerCheckTransfResponseToJson(this);

}