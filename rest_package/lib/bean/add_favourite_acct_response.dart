import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'add_favourite_acct_response.g.dart';

@JsonSerializable()
class AddFavouriteAcctResponse extends BaseResponse{

  final String firstName_Th;
  final String lastName_Th;
  final String acct_No;

  
  

  AddFavouriteAcctResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
      this.firstName_Th,
      this.lastName_Th,
      this.acct_No,) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory AddFavouriteAcctResponse.fromJson(Map<String, dynamic> json) => _$AddFavouriteAcctResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddFavouriteAcctResponseToJson(this);

}