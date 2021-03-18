import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'statement_request.g.dart';

@JsonSerializable()
class StatementRequest extends BaseRequest {
String dateStart;
String dateEnd;
String acctNo;
 

  StatementRequest({
    String reqRefNo,
    this.acctNo,
    this.dateEnd,
    this.dateStart,
   
  }) : super(reqRefNo);

  factory StatementRequest.fromJson(Map<String, dynamic> json) =>
      _$StatementRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StatementRequestToJson(this);
}
