import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';
import 'package:rest_package/model/select_account_to_add_group_list_model.dart';

part 'add_account_to_group_request.g.dart';

@JsonSerializable()
class AddAccountToGroupRequest extends BaseRequest {
  String groupName;
  List<SelectAccountToAddGroupModel>listAddAccountGroupRequest;
 
  AddAccountToGroupRequest({
    String reqRefNo,
    this.groupName,
    this.listAddAccountGroupRequest
   
  
  }) : super(reqRefNo);

  factory AddAccountToGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$AddAccountToGroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddAccountToGroupRequestToJson(this);
}
