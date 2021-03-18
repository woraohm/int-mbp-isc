import 'dart:convert';

import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screen_auth/authorizer_screen/authorizer_approve_order_screen/authorizer_check_screen.dart';
import 'package:flutter/material.dart';
import 'package:rest_package/bean/authorizor_bean/authorizer_list_order_request.dart';
import 'package:rest_package/bean/authorizor_bean/authorizer_list_order_response.dart';
import 'package:rest_package/connection/authorizer_connection/authorizer_list_order_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/model/authorizer_model/authorizer_list_order_model_response.dart';

class AuthorizerApproveOrderScreen extends StatefulWidget {
  @override
  _AuthorizerApproveOrderScreenState createState() => _AuthorizerApproveOrderScreenState();
}

class _AuthorizerApproveOrderScreenState extends State<AuthorizerApproveOrderScreen> {
  XSignature randReqRefNo = XSignature();
    var refreshKey = GlobalKey<RefreshIndicatorState>();
  AuthorizerListOrderConnection authorListConnect = AuthorizerListOrderConnection(globals.iPV4, '8080');
  Future<List<AuthorizerListOrderModelResponse>> getAuthorizerListOrder() async {
    List<AuthorizerListOrderModelResponse> res = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefGetAuthorizerListOrder: ' + reqRefNo);
    AuthorizerListOrderRequest request =
        AuthorizerListOrderRequest(reqRefNo: reqRefNo);
    await authorListConnect
        .connectAuthorizerListOrder(request, globals.token)
        .then((value) {
      //print('status code GetAuthorizerListOrder= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: '+value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        AuthorizerListOrderResponse response =
            AuthorizerListOrderResponse.fromJson(responseMap);
        print("respDescGetAuthorizerListOrder: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (AuthorizerListOrderModelResponse data in response.checkerListOrder) {
            res.add(data);
          }
          
        }
      }
    });
    return res;
  }
  
  @override
  void initState() {
    super.initState();
    refreshList();
    setState(() {
      getAuthorizerListOrder();
    });
}
    
Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      getAuthorizerListOrder();
    });

    return null;
  }
  
    
  
 
  
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFeaecf0),
        appBar: appBar(context, _height),
        body: Stack(
          children: [
            Container(
              height: _height,
              width: _width,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: _height * 0.02,
                          right: _height * 0.02,
                          top: _height * 0.02),
                      child: Text(
                        'รายการรออนุมัติ',
                        style: TextStyle(
                            fontSize: _height * 0.024,
                            color: Color(0xFF3d4351)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                ],
              ),
              
            ),
            _buildData(context),
          ],
        ),
      ),
    );
        // backgroundColor: Color(0xFFCFCFCF),
        // appBar: _buildAppBar(context, _height),
        //  body: Container(
        //     height: _height,
        //     width: _width,
        //     decoration: BoxDecoration(
        //         gradient: LinearGradient(
        //             begin: Alignment.center,
        //             end: Alignment.bottomCenter,
        //             colors: [Color(0xFFF4F0F9), Colors.white])),
        //     child: Stack(
        //       children: <Widget>[
        //         Column(
        //           children: <Widget>[
        //             SizedBox(
        //               height: _height * 0.02,
        //             ),
                    
        //             SizedBox(
        //               height: _height * 0.05,
        //             ),
        //             Container(
        //               height: _height * 0.2,
        //               width: _width,
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(45),
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ],
        //         ),
        //         Column(
        //           children: <Widget>[
        //             SizedBox(
        //               height: _height * 0.11,
        //             ),
        //             Container(
        //               padding: EdgeInsets.only(
        //                   left: _height * 0.02, right: _height * 0.02),
        //               height: _height * 0.73,
        //               width: _width,
        //               color: Colors.white,
        //               child: Container(
        //                 color: Colors.white,
        //                 child: _buildApproveOrder(context, _height),
        //               ),
        //             )
        //           ],
        //         )
        //       ],
        //     )),
      
    
  }
  Widget appBar(BuildContext context, double _height) {
    return AppBar(
      backgroundColor: Color(0xFF3b074b),
      centerTitle: true,
      title: Text(
        'รายการรออนุมัติ',
        style: TextStyle(fontSize: _height * 0.03),
      ),
    );
  }
  Widget _buildData(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: refreshList,
          child: Container(
        padding: EdgeInsets.only(
            left: _height * 0.02, right: _height * 0.02, top: _height * 0.01),
        alignment: Alignment.bottomCenter,
        width: _width,
        height: _height,
        child: Container(
          width: _width,
          height: _height * 0.83,
          child: FutureBuilder<List<AuthorizerListOrderModelResponse>>(
            future: getAuthorizerListOrder(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var data = snapshot.data;
                int lengthData = data.length;
                return lengthData!=0?
                ListView.builder(
                  itemCount: lengthData,
                  itemBuilder: (context, int index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthorizerCheckScreen(
                                        tracNo: data[index].trace_No,
                                      ))).then((onGoBack)),
                          child: Card(
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.only(
                                  // left: _height * 0.02,
                                  // right: _height * 0.02,
                                  // top: _height * 0.01
                                  ),
                              width: _width,
                              height: _height * 0.14,
                              
                              child: Row(
                                children: [
                                  // Container(
                                  //   width: _width * 0.03,
                                  //   height: _height,
                                  //   color: Color(0xFF3b074b),
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: _height * 0.01,
                                        right: _height * 0.01,
                                        top: _height * 0.01),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            data[index].transfer_Type_Description,
                                            style: TextStyle(
                                                fontSize: _height * 0.0245,
                                                color: Color(0xFF3d4351))),
                                        Text(
                                            'ปลายทาง ' +
                                                data[index].to_Acct_Name_Th,
                                            style: TextStyle(
                                                fontSize: _height * 0.022,
                                                color: Color(0xFF3d4351))),
                                        Text(
                                            'เลขที่รายการ ' +
                                                data[index].trace_No,
                                            style: TextStyle(
                                                fontSize: _height * 0.022,
                                                color: Color(0xFF3d4351))),
                                        Container(
                                          width: _width * 0.85,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                padding: EdgeInsets.only(
                                                    left: _height * 0.01,
                                                    right: _height * 0.01),
                                                height: _height * 0.023,
                                                child: Text(
                                                  'รออนุมัติ',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Text(
                                                data[index].dateTime,
                                                style: TextStyle(
                                                    fontSize: _height * 0.02,
                                                    color: Color(0xFF3d4351)),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ):Center(child: Text('ไม่มีข้อมูล', style: TextStyle(fontSize: _height*0.024),),);
              }
            },
          ),
        ),
      ),
    );
  }

  // Widget _buildApproveOrder(BuildContext context, double _height) {
  //   return ListView.builder(
  //     itemCount: 10,
  //     itemBuilder: (context, int index) {
  //       return Column(
  //         children: <Widget>[
  //           InkWell(
  //             onTap: () {
  //               Navigator.pushNamed(context, PageTo.authorizerCheckScreen);
  //             },
  //             child: ListTile(
  //               leading: CircleAvatar(
                  
  //                 backgroundImage:
  //                     AssetImage('assests/images/avatar-circle.png'),
  //               ),
  //               title: Text(
  //                 'รายการการโอนเงิน\nคุณ' + 'ตัวอย่าง' + ' ' + 'ตัวอย่าง',
  //                 style: TextStyle(fontSize: _height * 0.02),
  //               ),
  //               subtitle: Text(
  //                 'เลขที่รายการ ' + '1234567890',
  //                 style: TextStyle(fontSize: _height * 0.02),
  //               ),
  //               trailing: Column(
  //                 children: <Widget>[
  //                   Icon(Icons.arrow_forward_ios,
  //                       size: _height * 0.02, color: Color(0xFF7B2CBF)),
  //                   SizedBox(
  //                     height: _height * 0.011,
  //                   ),
  //                   Text(
  //                     '2 เม.ย 2563 - 18:18:10',
  //                     style: TextStyle(color: Colors.grey),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Divider()
  //         ],
  //       );
  //     },
  //   );
  // }
  void refreshData() {
    getAuthorizerListOrder();
  }

  onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }
}