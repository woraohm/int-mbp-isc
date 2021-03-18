import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'delete_favourite_acct_response.g.dart';

@JsonSerializable()
class DeleteFavouriteAcctResponse extends BaseResponse{
  String message;
  DeleteFavouriteAcctResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
      this.message
      ) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory DeleteFavouriteAcctResponse.fromJson(Map<String, dynamic> json) => _$DeleteFavouriteAcctResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteFavouriteAcctResponseToJson(this);

}