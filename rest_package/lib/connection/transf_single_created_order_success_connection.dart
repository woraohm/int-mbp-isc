import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rest_package/bean/transf_single_created_order_success_request.dart';
import 'package:rest_package/connection/abstract_connection.dart';
import 'package:rest_package/constant/header_constant.dart';
import 'package:rest_package/generator/x_signature.dart';

class TransfSingleCreatedOrderSuccessConnection extends AbstractConnection{

  TransfSingleCreatedOrderSuccessConnection(String url, String port) : super(url, port);

  Future<http.Response> transfSingleCreatedOrderSuccessConnection(TransfSingleCreatedOrderSuccessRequest request, String token){
    final endpoint = "mbp-rest/service/transCreatedSuccess";
    final url = includeEndpoint(endpoint);
    //print('url= '+url);
    final requestJson = jsonEncode(request.toJson());
    print('reqJson= '+requestJson);
    final headerMap = Map<String, String>.from(HeaderConstant.getBasicHeader());
    headerMap.addAll({
      HeaderConstant.xToken: token,
      HeaderConstant.xSignature: XSignature().generate(),
    });
    return http.post(url,
      headers: headerMap,
      body: requestJson
    );
  }

}