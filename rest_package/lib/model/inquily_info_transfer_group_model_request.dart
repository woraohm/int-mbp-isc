import 'package:json_annotation/json_annotation.dart';


part 'inquily_info_transfer_group_model_request.g.dart';

@JsonSerializable()
class InquilyInfoTransferGroupModelRequest {
  String sender_Account_No;
  String sender_Account_No_name_En;
  String sender_Account_No_name_Th;
  String bank_Name_Sender;
  String bank_Name_Recipient;
  String recipient_account_No;
  String recipient_account_No_name_Th;
  String recipient_account_No_name_En;
  double transAmount;

  

  InquilyInfoTransferGroupModelRequest({
    this.sender_Account_No,
    this.sender_Account_No_name_En,
    this.sender_Account_No_name_Th,
    this.bank_Name_Sender,
    this.bank_Name_Recipient,
    this.recipient_account_No,
    this.recipient_account_No_name_Th,
    this.recipient_account_No_name_En,
    this.transAmount

    

    
  });

   factory InquilyInfoTransferGroupModelRequest.fromJson(Map<String, dynamic> json) => _$InquilyInfoTransferGroupModelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InquilyInfoTransferGroupModelRequestToJson(this);
}
