import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'list_add_account_group_request.g.dart';

@JsonSerializable()
class ListAddAccountGroupRequest extends BaseRequest {
  final String nameGroup;
 

  ListAddAccountGroupRequest({
    String reqRefNo,
    this.nameGroup
   
  }) : super(reqRefNo);

  factory ListAddAccountGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$ListAddAccountGroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ListAddAccountGroupRequestToJson(this);
}
