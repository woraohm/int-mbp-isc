import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'select_member_to_group_request.g.dart';

@JsonSerializable()
class SelectMemberToGroupRequest extends BaseRequest {
  final String groupName;

 

  SelectMemberToGroupRequest({
    String reqRefNo,
    this.groupName,
   
  }) : super(reqRefNo);

  factory SelectMemberToGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$SelectMemberToGroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SelectMemberToGroupRequestToJson(this);
}
