import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';
import 'package:rest_package/model/checker_model/checker_history_check_model_response.dart';


part 'checker_history_check_response.g.dart';

@JsonSerializable()
class CheckerHistoryCheckResponse extends BaseResponse{
  List<CheckerHistoryCheckModelResponse> checkerListOrder;

  CheckerHistoryCheckResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.checkerListOrder,

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory CheckerHistoryCheckResponse.fromJson(Map<String, dynamic> json) => _$CheckerHistoryCheckResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckerHistoryCheckResponseToJson(this);

}