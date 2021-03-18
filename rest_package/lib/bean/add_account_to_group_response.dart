import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'add_account_to_group_response.g.dart';

@JsonSerializable()
class AddAccountToGroupResponse extends BaseResponse{

 

  AddAccountToGroupResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
    ) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory AddAccountToGroupResponse.fromJson(Map<String, dynamic> json) => _$AddAccountToGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddAccountToGroupResponseToJson(this);

}