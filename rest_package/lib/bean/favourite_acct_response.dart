import 'package:json_annotation/json_annotation.dart';

import 'package:rest_package/bean/base_response.dart';

import 'package:rest_package/model/favourite_acct_model_response.dart';

part 'favourite_acct_response.g.dart';

@JsonSerializable()
class FavouriteAcctResponse extends BaseResponse{
  List<FavouriteAcctModelResponse> listFavoriteAccount;

  FavouriteAcctResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.listFavoriteAccount,

  ):super(respCode, respDesc, reqRefNo, respRefNo);

  factory FavouriteAcctResponse.fromJson(Map<String, dynamic> json) => _$FavouriteAcctResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteAcctResponseToJson(this);

}