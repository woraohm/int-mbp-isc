import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_request.dart';

part 'transf_order_detail_request.g.dart';

@JsonSerializable()
class TransfOrderDetailRequest extends BaseRequest {
  final String traceNo;

 

  TransfOrderDetailRequest({
    String reqRefNo,
    this.traceNo,
   
  }) : super(reqRefNo);

  factory TransfOrderDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$TransfOrderDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransfOrderDetailRequestToJson(this);
}
