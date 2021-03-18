import 'package:json_annotation/json_annotation.dart';


part 'recent_transaction_model_response.g.dart';

@JsonSerializable()
class RecentTransactionModelResponse {
  String lkTransferType;
  String lkTransferTypeDes;
  String trfAcctNo;
  double amount;
  String dateTime;
  String trfBotBankName;
  

  RecentTransactionModelResponse({
    this.lkTransferType,
    this.lkTransferTypeDes,
    this.trfAcctNo,
    this.amount,
    this.dateTime,
    this.trfBotBankName,



    
  });

   factory RecentTransactionModelResponse.fromJson(Map<String, dynamic> json) => _$RecentTransactionModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecentTransactionModelResponseToJson(this);
}
