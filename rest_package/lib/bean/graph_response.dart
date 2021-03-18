import 'package:json_annotation/json_annotation.dart';


part 'graph_response.g.dart';

@JsonSerializable()
class GraphResponse {
  final double ostdBalance;
  final String accType;


  GraphResponse({
    this.ostdBalance,
    this.accType,
   
  });

   factory GraphResponse.fromJson(Map<String, dynamic> json) => _$GraphResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GraphResponseToJson(this);
}
