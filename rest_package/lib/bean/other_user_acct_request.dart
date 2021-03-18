import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'other_user_acct_request.g.dart';

@JsonSerializable()
class OtherUserAcctRequest extends BaseRequest {

 

  OtherUserAcctRequest({
    String reqRefNo,
   
  }) : super(reqRefNo);

  factory OtherUserAcctRequest.fromJson(Map<String, dynamic> json) =>
      _$OtherUserAcctRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OtherUserAcctRequestToJson(this);
}
