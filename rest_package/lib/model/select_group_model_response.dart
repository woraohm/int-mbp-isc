import 'package:json_annotation/json_annotation.dart';


part 'select_group_model_response.g.dart';

@JsonSerializable()
class SelectGroupModelResponse {
  final String nameGroup;
  final int countRecipient;
  final double totalAmount;
  
  

  SelectGroupModelResponse({
    this.nameGroup,
    this.countRecipient,
    this.totalAmount,
    
    
  });

   factory SelectGroupModelResponse.fromJson(Map<String, dynamic> json) => _$SelectGroupModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SelectGroupModelResponseToJson(this);
}
