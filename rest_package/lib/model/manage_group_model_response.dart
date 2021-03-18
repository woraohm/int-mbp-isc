import 'package:json_annotation/json_annotation.dart';


part 'manage_group_model_response.g.dart';

@JsonSerializable()
class ManageGroupModelResponse {
  double amount;
  String trfAcctNameTh;
  String bankName;
  String trfAcctNameEn;
  String trfAcctNo;

  

  ManageGroupModelResponse({
    this.amount,
    this.trfAcctNameTh,
    this.bankName,
    this.trfAcctNameEn,
    this.trfAcctNo
    
  });

   factory ManageGroupModelResponse.fromJson(Map<String, dynamic> json) => _$ManageGroupModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ManageGroupModelResponseToJson(this);
}
