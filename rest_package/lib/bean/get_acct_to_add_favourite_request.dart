import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'get_acct_to_add_favourite_request.g.dart';

@JsonSerializable()
class GetAcctToAddFavouriteRequest extends BaseRequest {

 
 
  GetAcctToAddFavouriteRequest({
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory GetAcctToAddFavouriteRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAcctToAddFavouriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetAcctToAddFavouriteRequestToJson(this);
}
