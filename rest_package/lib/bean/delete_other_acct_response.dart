import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'delete_other_acct_response.g.dart';

@JsonSerializable()
class DeleteOtherAcctResponse extends BaseResponse{

  
  
  

  DeleteOtherAcctResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory DeleteOtherAcctResponse.fromJson(Map<String, dynamic> json) => _$DeleteOtherAcctResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteOtherAcctResponseToJson(this);

}