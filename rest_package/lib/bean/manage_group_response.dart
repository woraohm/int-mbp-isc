import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';
import 'package:rest_package/model/manage_group_model_response.dart';


part 'manage_group_response.g.dart';

@JsonSerializable()
class ManageGroupResponse extends BaseResponse{
  String message;
  int countUser;
  List<ManageGroupModelResponse> listManageGroup;

  ManageGroupResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.listManageGroup,
    this.message

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory ManageGroupResponse.fromJson(Map<String, dynamic> json) => _$ManageGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ManageGroupResponseToJson(this);

}