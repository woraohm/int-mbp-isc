import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'delete_group_response.g.dart';

@JsonSerializable()
class DeleteGroupResponse extends BaseResponse{

  
  
  

  DeleteGroupResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory DeleteGroupResponse.fromJson(Map<String, dynamic> json) => _$DeleteGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteGroupResponseToJson(this);

}