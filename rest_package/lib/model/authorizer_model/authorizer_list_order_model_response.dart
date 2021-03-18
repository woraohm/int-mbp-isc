import 'package:json_annotation/json_annotation.dart';


part 'authorizer_list_order_model_response.g.dart';

@JsonSerializable()
class AuthorizerListOrderModelResponse{
  String trace_No;
  String to_Acct_Name_Th;
  String to_Acct_Name_En;
  String dateTime;
  String transfer_Type;
  String transfer_Type_Description;

  AuthorizerListOrderModelResponse({
    this.dateTime,
    this.to_Acct_Name_En,
    this.to_Acct_Name_Th,
    this.trace_No,
    this.transfer_Type,
    this.transfer_Type_Description
  });
   factory AuthorizerListOrderModelResponse.fromJson(Map<String, dynamic> json) => _$AuthorizerListOrderModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizerListOrderModelResponseToJson(this);
}