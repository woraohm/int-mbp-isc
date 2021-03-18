import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'checker_history_detail_request.g.dart';

@JsonSerializable()
class CheckerHistoryDetailRequest extends BaseRequest {
  final String trace_No;
 

  CheckerHistoryDetailRequest({
    String reqRefNo,
    this.trace_No,
   
  }) : super(reqRefNo);

  factory CheckerHistoryDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckerHistoryDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckerHistoryDetailRequestToJson(this);
}
