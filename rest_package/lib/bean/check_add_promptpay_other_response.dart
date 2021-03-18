import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'check_add_promptpay_other_response.g.dart';

@JsonSerializable()
class CheckAddPromptpayOtherResponse extends BaseResponse{

  final String prompt_Pay_No;
  final String acctName;
  
 
  
  

  CheckAddPromptpayOtherResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
      this.prompt_Pay_No,
      this.acctName,
     ) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory CheckAddPromptpayOtherResponse.fromJson(Map<String, dynamic> json) => _$CheckAddPromptpayOtherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAddPromptpayOtherResponseToJson(this);

}