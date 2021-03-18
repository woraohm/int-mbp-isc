import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';
import 'package:rest_package/model/list_add_account_group_model_response.dart';



part 'list_add_account_group_response.g.dart';

@JsonSerializable()
class ListAddAccountGroupResponse extends BaseResponse{
  List<ListAddAccountGroupModelResponse> listAcctsToAddFavAcct;

  ListAddAccountGroupResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.listAcctsToAddFavAcct,

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory ListAddAccountGroupResponse.fromJson(Map<String, dynamic> json) => _$ListAddAccountGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListAddAccountGroupResponseToJson(this);

}