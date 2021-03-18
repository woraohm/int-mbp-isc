import 'package:json_annotation/json_annotation.dart';


part 'transf_order_model_response.g.dart';

@JsonSerializable()
class TransfOrderModelResponse{
  String trace_No;
  String to_Acct_Name_Th;
  String to_Acct_Name_En;
  String dateTime;
  String trnStatus;

  TransfOrderModelResponse({
    this.dateTime,
    this.to_Acct_Name_En,
    this.to_Acct_Name_Th,
    this.trace_No,
    this.trnStatus,
  });
   factory TransfOrderModelResponse.fromJson(Map<String, dynamic> json) => _$TransfOrderModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransfOrderModelResponseToJson(this);
}