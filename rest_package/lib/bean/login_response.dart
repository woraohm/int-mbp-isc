import 'package:json_annotation/json_annotation.dart';
import 'package:rest_package/bean/base_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends BaseResponse{

  final String token;
  final String name_th;
  final String lastname_th;
  final String email;
  final String theme;
  final String name_Th_Company;
  final String mobile_No;
  
  

  LoginResponse(
      String respCode,
      String respDesc,
      String reqRefNo,
      String respRefNo,
      this.token,
      this.name_th,
      this.lastname_th,
      this.email,
      this.theme,
      this.name_Th_Company,
      this.mobile_No) : super(respCode, respDesc, reqRefNo, respRefNo);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

}