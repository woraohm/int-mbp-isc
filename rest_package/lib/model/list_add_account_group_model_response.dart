import 'package:json_annotation/json_annotation.dart';


part 'list_add_account_group_model_response.g.dart';

@JsonSerializable()
class ListAddAccountGroupModelResponse {
  final String firstName_Th;
  final String lastName_Th;
  final String accountNo;
  final String bankName;
  

  ListAddAccountGroupModelResponse({
    this.firstName_Th,
    this.lastName_Th,
    this.accountNo,
    this.bankName
    
  });

   factory ListAddAccountGroupModelResponse.fromJson(Map<String, dynamic> json) => _$ListAddAccountGroupModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListAddAccountGroupModelResponseToJson(this);
}
