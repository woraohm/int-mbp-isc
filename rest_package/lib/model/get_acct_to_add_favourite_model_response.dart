import 'package:json_annotation/json_annotation.dart';


part 'get_acct_to_add_favourite_model_response.g.dart';

@JsonSerializable()
class GetAcctToAddFavouriteModelResponse {
  final String acctName;
  final String acctNo;
  final String bankName;
  

  GetAcctToAddFavouriteModelResponse({
    this.acctName,
    this.acctNo,
    this.bankName
    
  });

   factory GetAcctToAddFavouriteModelResponse.fromJson(Map<String, dynamic> json) => _$GetAcctToAddFavouriteModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAcctToAddFavouriteModelResponseToJson(this);
}
