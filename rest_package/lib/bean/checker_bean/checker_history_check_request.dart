import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'checker_history_check_request.g.dart';

@JsonSerializable()
class CheckerHistoryCheckRequest extends BaseRequest {

 

  CheckerHistoryCheckRequest({
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory CheckerHistoryCheckRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckerHistoryCheckRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckerHistoryCheckRequestToJson(this);
}
