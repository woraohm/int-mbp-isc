import 'package:json_annotation/json_annotation.dart';


part 'checker_history_check_model_response.g.dart';

@JsonSerializable()
class CheckerHistoryCheckModelResponse{
  String trace_No;
  String to_Acct_Name_Th;
  String to_Acct_Name_En;
  String dateTime;
  String transfer_Type;
  String transfer_Type_Description;

  CheckerHistoryCheckModelResponse({
    this.dateTime,
    this.to_Acct_Name_En,
    this.to_Acct_Name_Th,
    this.trace_No,
    this.transfer_Type,
    this.transfer_Type_Description
  });
   factory CheckerHistoryCheckModelResponse.fromJson(Map<String, dynamic> json) => _$CheckerHistoryCheckModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckerHistoryCheckModelResponseToJson(this);
}