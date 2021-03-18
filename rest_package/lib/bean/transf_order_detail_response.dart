import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'transf_order_detail_response.g.dart';

@JsonSerializable()
class TransfOrderDetailResponse extends BaseResponse{

  final String traceNo;
  final String dateTime;

  final String sender_Account_No;
  final String lk_acct_type_name;
  final String bank_Name_Sender;
  final String bank_Name_Recipient;
  final String recipient_account_No;
  final String recipient_account_No_name_Th;
  final String recipient_account_No_name_En;
  final String note;
  final double fee;
  final double amount;
  final String trnStatus;

  
  

  TransfOrderDetailResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
      this.traceNo,
      this.dateTime,
      this.sender_Account_No,
      this.bank_Name_Sender,
      this.lk_acct_type_name,
      this.bank_Name_Recipient,
      this.recipient_account_No,
      this.recipient_account_No_name_Th,
      this.recipient_account_No_name_En,
      this.note,
      this.fee,
      this.amount,
      this.trnStatus
      ) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory TransfOrderDetailResponse.fromJson(Map<String, dynamic> json) => _$TransfOrderDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransfOrderDetailResponseToJson(this);

}