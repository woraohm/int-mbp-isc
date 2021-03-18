import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'accounts_request.g.dart';

@JsonSerializable()
class AccountsRequest extends BaseRequest {

 

  AccountsRequest({
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory AccountsRequest.fromJson(Map<String, dynamic> json) =>
      _$AccountsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AccountsRequestToJson(this);
}
