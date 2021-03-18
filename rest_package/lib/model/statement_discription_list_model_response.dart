import 'package:json_annotation/json_annotation.dart';


part 'statement_discription_list_model_response.g.dart';

@JsonSerializable()
class StatementDescriptionListModelResponse {
  String refNo;
  String period;
  int countOrder;
  double sumAmountTrnf; 
 
  

  StatementDescriptionListModelResponse({
    this.refNo,
    this.period,
    this.countOrder,
    this.sumAmountTrnf,

   


  });

   factory StatementDescriptionListModelResponse.fromJson(Map<String, dynamic> json) => _$StatementDescriptionListModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StatementDescriptionListModelResponseToJson(this);
}
