import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';


part 'ostdTotal_response.g.dart';

@JsonSerializable()
class OSTDTotalResponse extends BaseResponse{
  final double sumOstdBalance;
  

  OSTDTotalResponse(
    String respCode,
    String respDesc,
    String reqRefNo,
    String respRefNo,
    this.sumOstdBalance,
   
  ):super(respCode, respDesc, reqRefNo, respRefNo);

   factory OSTDTotalResponse.fromJson(Map<String, dynamic> json) => _$OSTDTotalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OSTDTotalResponseToJson(this);
}
