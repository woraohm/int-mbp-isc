import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'delete_group_request.g.dart';

@JsonSerializable()
class DeleteGroupRequest extends BaseRequest {
  final String groupName;


 

  DeleteGroupRequest({
    String reqRefNo,

    this.groupName
   
  }) : super(reqRefNo);

  factory DeleteGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteGroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteGroupRequestToJson(this);
}
