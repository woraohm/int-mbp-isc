import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';


import 'package:rest_package/model/select_member_to_group_model_response.dart';

part 'select_member_to_group_response.g.dart';

@JsonSerializable()
class SelectMemberToGroupResponse extends BaseResponse{
  List<SelectMemberToGroupModelResponse> listAcctNo;
 
  

  SelectMemberToGroupResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.listAcctNo,
   
    

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory SelectMemberToGroupResponse.fromJson(Map<String, dynamic> json) => _$SelectMemberToGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SelectMemberToGroupResponseToJson(this);

}