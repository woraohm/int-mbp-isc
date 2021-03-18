import 'package:json_annotation/json_annotation.dart';


part 'checker_list_order_model_response.g.dart';

@JsonSerializable()
class CheckerListOrderModelResponse{
  String trace_No;
  String to_Acct_Name_Th;
  String to_Acct_Name_En;
  String dateTime;
  String transfer_Type;
  String transfer_Type_Description;

  CheckerListOrderModelResponse({
    this.dateTime,
    this.to_Acct_Name_En,
    this.to_Acct_Name_Th,
    this.trace_No,
    this.transfer_Type,
    this.transfer_Type_Description
  });
   factory CheckerListOrderModelResponse.fromJson(Map<String, dynamic> json) => _$CheckerListOrderModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckerListOrderModelResponseToJson(this);
}