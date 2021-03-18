import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'select_group_request.g.dart';

@JsonSerializable()
class SelectGroupRequest extends BaseRequest {

 

  SelectGroupRequest({
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory SelectGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$SelectGroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SelectGroupRequestToJson(this);
}
