import 'package:json_annotation/json_annotation.dart';


part 'select_member_to_group_model_response.g.dart';

@JsonSerializable()
class SelectMemberToGroupModelResponse {
  final String acctNo;
  final String acctName;
  final String bankName;
  
  
  

  SelectMemberToGroupModelResponse({
    this.acctNo,
    this.acctName,
    this.bankName,
    
    
  });

   factory SelectMemberToGroupModelResponse.fromJson(Map<String, dynamic> json) => _$SelectMemberToGroupModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SelectMemberToGroupModelResponseToJson(this);
}
