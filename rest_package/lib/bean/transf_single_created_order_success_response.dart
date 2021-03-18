import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'transf_single_created_order_success_response.g.dart';

@JsonSerializable()
class TransfSingleCreatedOrderSuccessResponse extends BaseResponse{

  final String traceNo;
  final String dateTime;
  final String sender_Account_No;
  final String sender_lk_acct_type_name;
  final String bank_Name_Sender;  
  final String bank_Name_Recipient;
  final String sender_Account_No_name_Th;
  final String sender_Account_No_name_En;
  final String recipient_account_No;
  final String recipient_account_No_name_Th;
  final String recipient_account_No_name_En;
  final String note;
  final double fee;
  final double amount;

  
  

  TransfSingleCreatedOrderSuccessResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
      this.traceNo,
      this.dateTime,
      this.sender_Account_No,
      this.sender_lk_acct_type_name,
      this.bank_Name_Sender,
      this.bank_Name_Recipient,
      this.sender_Account_No_name_En,
      this.sender_Account_No_name_Th,
      this.recipient_account_No,
      this.recipient_account_No_name_Th,
      this.recipient_account_No_name_En,
      this.note,
      this.fee,
      this.amount
      ) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory TransfSingleCreatedOrderSuccessResponse.fromJson(Map<String, dynamic> json) => _$TransfSingleCreatedOrderSuccessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransfSingleCreatedOrderSuccessResponseToJson(this);

}