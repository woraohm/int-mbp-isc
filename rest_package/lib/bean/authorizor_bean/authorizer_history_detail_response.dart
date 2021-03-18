import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';



part 'authorizer_history_detail_response.g.dart';

@JsonSerializable()
class AuthorizerHistoryDetailResponse extends BaseResponse{
  String traceNo;
  String sender_Account_No;
  String dateTime;
  String bank_Name_Sender_Th;
  String bank_Name_Sender_En;
  String bank_Name_Recipient;
  String recipient_account_No;
  String recipient_account_No_name_Th;
  String recipient_account_No_name_En;
  double amount;
  String note;
  double fee;
  String name_Check;
  String sender_Account_Type;
  String trnStatus;

  AuthorizerHistoryDetailResponse({
     String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.traceNo,
    this.sender_Account_No,
    this.dateTime,
    this.bank_Name_Sender_Th,
    this.bank_Name_Sender_En,
    this.bank_Name_Recipient,
    this.recipient_account_No,
    this.recipient_account_No_name_Th,
    this.recipient_account_No_name_En,
    this.amount,
    this.note,
    this.fee,
    this.name_Check,
    this.sender_Account_Type,
    this.trnStatus
  }):super(respCode, respDesc, reqRefNo, respRefNo);

  factory AuthorizerHistoryDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthorizerHistoryDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizerHistoryDetailResponseToJson(this);

}




