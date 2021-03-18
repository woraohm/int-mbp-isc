import 'dart:convert';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screen_auth/authorizer_screen/authorizer_history_screen/authorizer_hisrory_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rest_package/bean/authorizor_bean/authorizer_history_order_request.dart';
import 'package:rest_package/bean/authorizor_bean/authorizer_history_order_response.dart';
import 'package:rest_package/connection/authorizer_connection/authorizer_history_order_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/model/authorizer_model/authorizer_history_order_model_response.dart';

class AuthorizerHistoryScreen extends StatefulWidget {
  @override
  _AuthorizerHistoryScreenState createState() => _AuthorizerHistoryScreenState();
}

class _AuthorizerHistoryScreenState extends State<AuthorizerHistoryScreen> {
  AuthorizerHistoryOrderConnection authorizerHistoryOrderConnection = AuthorizerHistoryOrderConnection(globals.iPV4, '8080');
  FunctionGlobal func = FunctionGlobal();
  XSignature randReqRefNo = XSignature();

  
  Future<List<AuthorizerHistoryOrderModelResponse>> getAuthorizerHistoryOrder() async {
    List<AuthorizerHistoryOrderModelResponse> res = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefGetgetAuthorizerHistoryOrder: ' + reqRefNo);
    AuthorizerHistoryOrderRequest request =
        AuthorizerHistoryOrderRequest(reqRefNo: reqRefNo);
    await authorizerHistoryOrderConnection
        .connectAuthorizerHistoryOrder(request, globals.token)
        .then((value) {
      //print('status code getAuthorizerHistoryOrder= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: '+value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        AuthorizerHistoryOrderResponse response =
            AuthorizerHistoryOrderResponse.fromJson(responseMap);
        print("respDescGetgetAuthorizerHistoryOrder: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (AuthorizerHistoryOrderModelResponse data
              in response.checkerListOrder) {
            res.add(data);
          }
        }
      }
    });
    return res;
  }
  
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
     return SafeArea(
      child: Scaffold(

        appBar: _buildAppBar(context),
        body: Container(
          padding: EdgeInsets.only(right: _height*0.01, left: _height*0.01, top: _height*0.02),
          height: _height,
          width: _width,
          child: buildHistoryAuthorizerOrder(context, _height),
        ),

      ),
      
    );
  }
  Widget _buildAppBar(
    BuildContext context,
  ) {
    final double _height = MediaQuery.of(context).size.height;
    return AppBar(
      
      backgroundColor: backgroundMainColor,
      centerTitle: true,
      title: Text(
        'ประวัติการอนุมัติรายการ',
        style: TextStyle(fontSize: _height * 0.03),
      ),
    );
  }

  Widget buildHistoryAuthorizerOrder(BuildContext context, double _height) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<AuthorizerHistoryOrderModelResponse>>(
      future: getAuthorizerHistoryOrder(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var data = snapshot.data;
          int length = data.length;
          return length!=0?
          ListView.builder(
            itemCount: length,
            itemBuilder: (context, int index) {
              return Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthorizerHistoryOrderScreen(
                                    tracNo: data[index].trace_No,
                                  )));
                    },
                    child: Card(
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: _height * 0.02,
                            right: _height * 0.02,
                            top: _height * 0.01),
                        width: _width,
                        height: _height * 0.14,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data[index].transfer_Type_Description,
                              style: TextStyle(
                                fontSize: _height * 0.025,
                              ),
                            ),
                            Text(
                              'ปลายทาง ' + data[index].to_Acct_Name_Th,
                              style: TextStyle(
                                  fontSize: _height * 0.023,
                                  color: Colors.grey[700]),
                            ),
                            Text(
                              'เลขที่อ้างอิง ' + data[index].trace_No,
                              style: TextStyle(
                                  fontSize: _height * 0.023,
                                  color: Colors.grey[700]),
                            ),
                            Container(
                              width: _width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Jiffy(data[index].dateTime).yMMMMEEEEdjm,
                                    style: TextStyle(
                                        fontSize: _height * 0.018,
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    'ข้อมูลเพิ่มเติม',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.grey[700]),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryCheckerOrderScreen(tracNo: data[index].trace_No,)));

                  //   },
                  //   child: ListTile(

                  //     title: Text(
                  //       data[index].transfer_Type_Description+'\n'+ data[index].to_Acct_Name_Th,
                  //       style: TextStyle(fontSize: _height * 0.02),
                  //     ),
                  //     subtitle: Text(
                  //       'เลขที่รายการ ' + data[index].trace_No,
                  //       style: TextStyle(fontSize: _height * 0.02),
                  //     ),
                  //     trailing: Column(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: <Widget>[
                  //         Icon(Icons.arrow_forward_ios,
                  //             size: _height * 0.02, color: Color(0xFF3b074b)),
                  //         SizedBox(
                  //           height: _height * 0.011,
                  //         ),
                  //         Text(
                  //           data[index].dateTime,
                  //           style: TextStyle(color: Colors.grey),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              );
            },
          ):Center(child: Text('ไม่มีข้อมูล', style: TextStyle(fontSize: _height*0.024),),);
        }
      },
    );
  }
}