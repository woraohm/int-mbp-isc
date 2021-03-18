

import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';

import 'package:rest_package/model/inquily_info_transfer_group_model_response.dart';


part 'inquily_info_transfer_group_response.g.dart';

@JsonSerializable()
class InquilyInfoTransferGroupResponse extends BaseResponse {

  List<InquilyInfoTransferGroupModelResponse>listResponse;
 
  InquilyInfoTransferGroupResponse({
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.listResponse
   
  
  }) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory InquilyInfoTransferGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$InquilyInfoTransferGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InquilyInfoTransferGroupResponseToJson(this);
}
