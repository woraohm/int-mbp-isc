import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'create_group_request.g.dart';

@JsonSerializable()
class CreateGroupRequest extends BaseRequest {
  final String groupName;
 

  CreateGroupRequest({
    String reqRefNo,
    this.groupName
   
  }) : super(reqRefNo);

  factory CreateGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateGroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGroupRequestToJson(this);
}
