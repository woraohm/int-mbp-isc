import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'manage_group_request.g.dart';

@JsonSerializable()
class ManageGroupRequest extends BaseRequest {
  final String groupName;
 

  ManageGroupRequest({
    String reqRefNo,
    this.groupName
   
  }) : super(reqRefNo);

  factory ManageGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$ManageGroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ManageGroupRequestToJson(this);
}
