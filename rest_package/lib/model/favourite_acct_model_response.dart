import 'package:json_annotation/json_annotation.dart';


part 'favourite_acct_model_response.g.dart';

@JsonSerializable()
class FavouriteAcctModelResponse {
  final String acctName;
  final String acctNo;
  final String bankName;
  

  FavouriteAcctModelResponse({
    this.acctName,
    this.acctNo,
    this.bankName
  });

   factory FavouriteAcctModelResponse.fromJson(Map<String, dynamic> json) => _$FavouriteAcctModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteAcctModelResponseToJson(this);
}
