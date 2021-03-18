import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'change_group_response.g.dart';

@JsonSerializable()
class ChangeGroupResponse extends BaseResponse{

  final String groupName;
  
 
  
  

  ChangeGroupResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
      this.groupName,
     
     ) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory ChangeGroupResponse.fromJson(Map<String, dynamic> json) => _$ChangeGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeGroupResponseToJson(this);

}