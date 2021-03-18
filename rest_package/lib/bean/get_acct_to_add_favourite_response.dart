import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';

import 'package:rest_package/model/get_acct_to_add_favourite_model_response.dart';

part 'get_acct_to_add_favourite_response.g.dart';

@JsonSerializable()
class GetAcctToAddFavouriteResponse extends BaseResponse{
  List<GetAcctToAddFavouriteModelResponse> listAcctCompany;
  List<GetAcctToAddFavouriteModelResponse> listAcctOther;

  GetAcctToAddFavouriteResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.listAcctCompany,
    this.listAcctOther,

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory GetAcctToAddFavouriteResponse.fromJson(Map<String, dynamic> json) => _$GetAcctToAddFavouriteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAcctToAddFavouriteResponseToJson(this);

}