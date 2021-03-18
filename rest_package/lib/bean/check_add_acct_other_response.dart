import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'check_add_acct_other_response.g.dart';

@JsonSerializable()
class CheckAddAcctOtherResponse extends BaseResponse{

  final String acctNo;
  final String nameTh;
  final String nameEn;
  

 CheckAddAcctOtherResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
      
      this.acctNo,
      this.nameEn,
      this.nameTh) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory CheckAddAcctOtherResponse.fromJson(Map<String, dynamic> json) => _$CheckAddAcctOtherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAddAcctOtherResponseToJson(this);

}