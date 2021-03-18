import 'dart:convert';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screen_auth/checker_screen/checker_history_screen/checker_history_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:rest_package/bean/checker_bean/checker_history_check_request.dart';
import 'package:rest_package/bean/checker_bean/checker_history_check_response.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/connection/checker_connection/checker_history_check_connection.dart';
import 'package:rest_package/model/checker_model/checker_history_check_model_response.dart';
import 'package:jiffy/jiffy.dart';

class HistoryCheckerScreen extends StatefulWidget {
  @override
  _HistoryCheckerScreenState createState() => _HistoryCheckerScreenState();
}

class _HistoryCheckerScreenState extends State<HistoryCheckerScreen> {
  FunctionGlobal func = FunctionGlobal();
  XSignature randReqRefNo = XSignature();
  CheckerHistoryCheckConnection checkHistoryCheckConnect =
      CheckerHistoryCheckConnection(globals.iPV4, '8080');
  checkLogoBank(String bankName) {
    switch (bankName) {
      case "ไทยพาณิชย์":
        return AssetImage('assests/images/SCB-logo.png');
        break;
      case "กรุงเทพ":
        return AssetImage('assests/images/BBL-logo.png');
        break;
      case "กรุงไทย":
        return AssetImage('assests/images/KTB-logo.png');
        break;
      case "กรุงศรีอยุธยา":
        return AssetImage('assests/images/BAY.png');
        break;
      case "กสิกรไทย":
        return AssetImage('assests/images/KBANK-logo.png');
        break;
      case "ทหารไทย":
        return AssetImage('assests/images/TMB-logo.png');
        break;
      case "ธนชาติ ":
        return AssetImage('assests/images/NBANK-logo.png');
        break;
      case "อาคารสงเคราะห์":
        return AssetImage('assests/images/GHB-logo.jpg');
        break;
      case "ออมสิน":
        return AssetImage('assests/images/GSB-logo.jpg');
        break;

      default:
        return null;
    }
  }

  Future<List<CheckerHistoryCheckModelResponse>> getHistoryChecker() async {
    List<CheckerHistoryCheckModelResponse> res = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefGetgetHistoryChecker: ' + reqRefNo);
    CheckerHistoryCheckRequest request =
        CheckerHistoryCheckRequest(reqRefNo: reqRefNo);
    await checkHistoryCheckConnect
        .connectCheckerHistoryCheck(request, globals.token)
        .then((value) {
      //print('status code getHistoryChecker= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: '+value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        CheckerHistoryCheckResponse response =
            CheckerHistoryCheckResponse.fromJson(responseMap);
        print("respDescGetgetHistoryChecker: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (CheckerHistoryCheckModelResponse data
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
          color: Color(0xFFeaecf0),
          padding: EdgeInsets.only(
              right: _height * 0.01, left: _height * 0.01, top: _height * 0.02),
          height: _height,
          width: _width,
          child: buildHistoryCheckOrder(context),
        ),
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
  ) {
    final double _height = MediaQuery.of(context).size.height;
    return AppBar(
      backgroundColor: Color(0xFF3b074b),
      leading: func.appBarPop(context),
      centerTitle: true,
      title: Text(
        'ประวัติการตรวจสอบ',
        style: TextStyle(fontSize: _height * 0.03),
      ),
    );
  }

  Widget buildHistoryCheckOrder(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<CheckerHistoryCheckModelResponse>>(
      future: getHistoryChecker(),
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
                              builder: (context) => HistoryCheckerOrderScreen(
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
