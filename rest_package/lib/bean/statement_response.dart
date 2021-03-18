import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';
import 'package:rest_package/model/statement_discription_list_model_response.dart';

import 'package:rest_package/model/statement_list_model_response.dart';

part 'statement_response.g.dart';

@JsonSerializable()
class StatementResponse extends BaseResponse{
  List<StatementListModelResponse> statementList;
  List<StatementDescriptionListModelResponse> descriptionStatementList;


  StatementResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.statementList,
    this.descriptionStatementList

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory StatementResponse.fromJson(Map<String, dynamic> json) => _$StatementResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StatementResponseToJson(this);

}