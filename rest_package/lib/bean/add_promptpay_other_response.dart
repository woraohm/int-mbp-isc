import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'add_promptpay_other_response.g.dart';

@JsonSerializable()
class AddPromptpayOtherResponse extends BaseResponse{

  final String message;
 
  
 
  
  

  AddPromptpayOtherResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
      this.message,
     ) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory AddPromptpayOtherResponse.fromJson(Map<String, dynamic> json) => _$AddPromptpayOtherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddPromptpayOtherResponseToJson(this);

}