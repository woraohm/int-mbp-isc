import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'change_group_request.g.dart';

@JsonSerializable()
class ChangeGroupRequest extends BaseRequest {
  final String groupNameOld;
  final String groupNameNew;
 

  ChangeGroupRequest({
    String reqRefNo,
    this.groupNameOld,
    this.groupNameNew,
   
  }) : super(reqRefNo);

  factory ChangeGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangeGroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeGroupRequestToJson(this);
}
