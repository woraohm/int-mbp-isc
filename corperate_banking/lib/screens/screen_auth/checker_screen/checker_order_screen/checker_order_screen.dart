import 'dart:convert';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screen_auth/checker_screen/checker_check_screen/checker_checking_screen.dart';
import 'package:flutter/material.dart';
import 'package:rest_package/bean/checker_bean/checker_list_order_request.dart';
import 'package:rest_package/bean/checker_bean/checker_list_order_response.dart';
import 'package:rest_package/connection/checker_connection/checker_list_order_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/model/checker_model/checker_list_order_model_response.dart';

class CheckerOrderScreen extends StatefulWidget {
  @override
  _CheckerOrderScreenState createState() => _CheckerOrderScreenState();
}

class _CheckerOrderScreenState extends State<CheckerOrderScreen> {
  FunctionGlobal func = FunctionGlobal();
  XSignature randReqRefNo = XSignature();
  CheckerListOrderAllConnection checkerListOrderConnect =
      CheckerListOrderAllConnection(globals.iPV4, '8080');

  Future<List<CheckerListOrderModelResponse>> getCheckerListOrder() async {
    List<CheckerListOrderModelResponse> res = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefGetCheckerListOrder: ' + reqRefNo);
    CheckerListOrderRequest request =
        CheckerListOrderRequest(reqRefNo: reqRefNo);
    await checkerListOrderConnect
        .connectCheckerListOrderAll(request, globals.token)
        .then((value) {
      //print('status code GetCheckerListOrder= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: '+value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        CheckerListOrderResponse response =
            CheckerListOrderResponse.fromJson(responseMap);
        print("respDescGetCheckerListOrder: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (CheckerListOrderModelResponse data
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
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: ()=>func.onBackPressed(context),
          child: SafeArea(
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
                          'รายการรอตรวจสอบ',
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
      ),
    );
  }

  Widget appBar(BuildContext context, double _height) {
    return AppBar(
      backgroundColor: Color(0xFF3b074b),
      leading: func.appBarPop(context),
      centerTitle: true,
      title: Text(
        'รายการตรวจสอบ',
        style: TextStyle(fontSize: _height * 0.03),
      ),
    );
  }

  Widget buildCheckOrder(BuildContext context, double _height) {
    return FutureBuilder<List<CheckerListOrderModelResponse>>(
      future: getCheckerListOrder(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var data = snapshot.data;
          var lengthData = data.length;
          return ListView.builder(
            itemCount: lengthData,
            itemBuilder: (context, int index) {
              return Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckerCheckingScreen(
                                    tracNo: data[index].trace_No,
                                  )));
                      // Navigator.pushNamed(
                      //     context, PageTo.checkerCheckingScreen);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assests/images/avatar-circle.png'),
                      ),
                      title: Text(
                        'รายการ' +
                            data[index].transfer_Type_Description +
                            '\nคุณ' +
                            data[index].to_Acct_Name_Th,
                        style: TextStyle(fontSize: _height * 0.024),
                      ),
                      subtitle: Text(
                        'เลขที่รายการ ' + data[index].trace_No,
                        style: TextStyle(fontSize: _height * 0.02),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(Icons.arrow_forward_ios,
                              size: _height * 0.02, color: Color(0xFF3b074b)),
                          SizedBox(
                            height: _height * 0.011,
                          ),
                          Text(
                            '',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider()
                ],
              );
            },
          );
        }
      },
    );
  }

  Widget _buildData(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(
          left: _height * 0.02, right: _height * 0.02, top: _height * 0.01),
      alignment: Alignment.bottomCenter,
      width: _width,
      height: _height,
      child: Container(
        width: _width,
        height: _height * 0.83,
        child: FutureBuilder<List<CheckerListOrderModelResponse>>(
          future: getCheckerListOrder(),
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
                                builder: (context) => CheckerCheckingScreen(
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
                                                'รอตรวจสอบ',
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
    );
  }
  void refreshData() {
    getCheckerListOrder();
  }

  onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }
}
