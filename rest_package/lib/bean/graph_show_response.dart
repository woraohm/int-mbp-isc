import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';
import 'package:rest_package/bean/graph_response.dart';

part 'graph_show_response.g.dart';

@JsonSerializable()
class GraphShowResponse extends BaseResponse{
  List<GraphResponse> accountList;

  GraphShowResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.accountList,

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory GraphShowResponse.fromJson(Map<String, dynamic> json) => _$GraphShowResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GraphShowResponseToJson(this);

}