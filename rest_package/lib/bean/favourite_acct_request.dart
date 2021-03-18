import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'favourite_acct_request.g.dart';

@JsonSerializable()
class FavouriteAcctRequest extends BaseRequest {

 

  FavouriteAcctRequest({
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory FavouriteAcctRequest.fromJson(Map<String, dynamic> json) =>
      _$FavouriteAcctRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteAcctRequestToJson(this);
}
