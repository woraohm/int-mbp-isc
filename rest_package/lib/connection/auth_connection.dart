import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rest_package/bean/login_request.dart';
import 'package:rest_package/connection/abstract_connection.dart';
import 'package:rest_package/constant/header_constant.dart';
import 'package:rest_package/generator/x_signature.dart';

class AuthConnection extends AbstractConnection{

  AuthConnection(String url, String port) : super(url, port);

  Future<http.Response> login(LoginRequest request){
    final endpoint = "mbp-rest/auth/login";
    final url = includeEndpoint(endpoint);
    //print('url= '+url);
    final requestJson = jsonEncode(request.toJson());
    //print('reqJson= '+requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xSignature: XSignature().generate(),
    });
    return http.post(url,
      headers: headerMap,
      body: requestJson
    );
  }

}