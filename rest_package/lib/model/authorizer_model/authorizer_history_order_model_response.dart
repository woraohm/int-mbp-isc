import 'package:json_annotation/json_annotation.dart';


part 'authorizer_history_order_model_response.g.dart';

@JsonSerializable()
class AuthorizerHistoryOrderModelResponse{
  String trace_No;
  String to_Acct_Name_Th;
  String to_Acct_Name_En;
  String dateTime;
  String transfer_Type;
  String transfer_Type_Description;

  AuthorizerHistoryOrderModelResponse({
    this.dateTime,
    this.to_Acct_Name_En,
    this.to_Acct_Name_Th,
    this.trace_No,
    this.transfer_Type,
    this.transfer_Type_Description
  });
   factory AuthorizerHistoryOrderModelResponse.fromJson(Map<String, dynamic> json) => _$AuthorizerHistoryOrderModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizerHistoryOrderModelResponseToJson(this);
}