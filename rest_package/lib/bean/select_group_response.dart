import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';

import 'package:rest_package/model/select_group_model_response.dart';

part 'select_group_response.g.dart';

@JsonSerializable()
class SelectGroupResponse extends BaseResponse{
  List<SelectGroupModelResponse> listGroup;
  int lenghtList;

  SelectGroupResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.listGroup,
    this.lenghtList

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory SelectGroupResponse.fromJson(Map<String, dynamic> json) => _$SelectGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SelectGroupResponseToJson(this);

}