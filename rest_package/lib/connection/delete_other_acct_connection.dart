import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rest_package/bean/delete_other_acct_request.dart';
import 'package:rest_package/connection/abstract_connection.dart';
import 'package:rest_package/constant/header_constant.dart';
import 'package:rest_package/generator/x_signature.dart';

class DeleteOtherAcctConnection extends AbstractConnection{

  DeleteOtherAcctConnection(String url, String port) : super(url, port);

  Future<http.Response> connectDeleteOtherAcct(DeleteOtherAcctRequest request, String token){
    final endpoint = "mbp-rest/service/deleteOtherAcct";
    final url = includeEndpoint(endpoint);
    //print('url= '+url);
    final requestJson = jsonEncode(request.toJson());
    //print('reqJson= '+requestJson);
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
    



  





  

