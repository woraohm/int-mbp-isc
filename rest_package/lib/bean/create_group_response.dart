import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'create_group_response.g.dart';

@JsonSerializable()
class CreateGroupResponse extends BaseResponse{

  final String message;
  
 
  
  

  CreateGroupResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
      this.message,
     
     ) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory CreateGroupResponse.fromJson(Map<String, dynamic> json) => _$CreateGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGroupResponseToJson(this);

}