import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'add_other_user_acct_response.g.dart';

@JsonSerializable()
class AddOtherUserAcctResponse extends BaseResponse{

  AddOtherUserAcctResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory AddOtherUserAcctResponse.fromJson(Map<String, dynamic> json) => _$AddOtherUserAcctResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddOtherUserAcctResponseToJson(this);

}