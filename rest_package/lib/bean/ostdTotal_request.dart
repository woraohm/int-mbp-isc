import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'ostdTotal_request.g.dart';

@JsonSerializable()
class OSTDTotalRequest extends BaseRequest {

 

  OSTDTotalRequest({
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory OSTDTotalRequest.fromJson(Map<String, dynamic> json) =>
      _$OSTDTotalRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OSTDTotalRequestToJson(this);
}
