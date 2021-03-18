import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';
import 'package:rest_package/model/inquily_info_transfer_group_model_request.dart';


part 'inquily_info_transfer_group_request.g.dart';

@JsonSerializable()
class InquilyInfoTransferGroupRequest extends BaseRequest {

  List<InquilyInfoTransferGroupModelRequest>listRequest;
 
  InquilyInfoTransferGroupRequest({
    String reqRefNo,

    this.listRequest
   
  
  }) : super(reqRefNo);

  factory InquilyInfoTransferGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$InquilyInfoTransferGroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InquilyInfoTransferGroupRequestToJson(this);
}
