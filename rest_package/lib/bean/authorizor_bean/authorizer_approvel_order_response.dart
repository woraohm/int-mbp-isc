import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'authorizer_approvel_order_response.g.dart';

@JsonSerializable()
class AuthorizerApprovelOrderResponse extends BaseResponse{

  final String traceNo;
  final String dateTime;
  final String sender_Account_No;
  final String bank_Name_Sender_Th;
  final String bank_Name_Sender_En;
  final String sender_Account_Type;
  final String bank_Name_Recipient;
  final String recipient_account_No;
  final String recipient_account_No_name_Th;
  final String recipient_account_No_name_En;
  final String note;
  final double fee;
  final double amount;
  final String trnStatus;
  final String message;
  final String name_Check;
 
  

  
  

  AuthorizerApprovelOrderResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
      this.traceNo,
      this.dateTime,
      this.sender_Account_No,
      this.bank_Name_Sender_Th,
      this.bank_Name_Sender_En,
      this.sender_Account_Type,
      this.bank_Name_Recipient,
      this.recipient_account_No,
      this.recipient_account_No_name_Th,
      this.recipient_account_No_name_En,
      this.note,
      this.fee,
      this.amount,
      this.trnStatus,
      this.message,
      this.name_Check
      
      ) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory AuthorizerApprovelOrderResponse.fromJson(Map<String, dynamic> json) => _$AuthorizerApprovelOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizerApprovelOrderResponseToJson(this);

}