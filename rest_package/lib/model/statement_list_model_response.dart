import 'package:json_annotation/json_annotation.dart';


part 'statement_list_model_response.g.dart';

@JsonSerializable()
class StatementListModelResponse {
  String dateTime;
  String description;
  String traceNo;
  double availBalAmt;
  double ledgerBalAmt;
  String frBankName;
  String frAcctNo;
  String frAcctNameTh;
  String frAcctNameEn;
  double amount;
  String destBankName;
  String destAcctNo;
  String destAcctNameTh;
  String destAcctNameEn;
  

  StatementListModelResponse({
    this.dateTime,
    this.description,
    this.traceNo,
    this.availBalAmt,
    this.ledgerBalAmt,
    this.frBankName,
    this.frAcctNo,
    this.frAcctNameTh,
    this.frAcctNameEn,
    this.amount,
    this.destBankName,
    this.destAcctNo,
    this.destAcctNameTh,
    this.destAcctNameEn


  });

   factory StatementListModelResponse.fromJson(Map<String, dynamic> json) => _$StatementListModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StatementListModelResponseToJson(this);
}
