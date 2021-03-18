import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'graph_request.g.dart';

@JsonSerializable()
class GraphRequest extends BaseRequest {

 

  GraphRequest({
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory GraphRequest.fromJson(Map<String, dynamic> json) =>
      _$GraphRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GraphRequestToJson(this);
}
