import 'dart:convert';

import 'package:corperate_banking/global_function.dart';

import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rest_package/bean/recent_transaction_request.dart';
import 'package:rest_package/bean/recent_transaction_response.dart';
import 'package:rest_package/connection/recent_transaction_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/model/recent_transaction_model_response.dart';

final formatMoney = new NumberFormat("#,##0.00", "en_US");

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  XSignature randReqRefNo = XSignature();
  FunctionGlobal func = FunctionGlobal();
  RecentTransactionConnection recentTransactionConnect = RecentTransactionConnection(globals.iPV4, '8080');

  

  bool visibilityHistory = true;
  bool visibilityStatement = false;


  //menuhistory
  bool aWeek = false;
  bool aMonth = false;
  bool threeMonth = false;
  bool sixMonth = false;
  bool aYear = false;
  bool threeYears = false;
  bool fiveYears = false;
  bool all = false;
 

 
  
  



  checkLogoBank(String bankName) {
    switch (bankName) {
      case "SCB":
        return AssetImage('assests/images/SCB-logo.png');
        break;
      case "BBL":
        return AssetImage('assests/images/BBL-logo.png');
        break;
      case "KTB":
        return AssetImage('assests/images/KTB-logo.png');
        break;
      case "BAY":
        return AssetImage('assests/images/BAY.png');
        break;
      case "KBANK":
        return AssetImage('assests/images/KBANK-logo.png');
        break;
      case "TMB":
        return AssetImage('assests/images/TMB-logo.png');
        break;
      case "NBANK":
        return AssetImage('assests/images/NBANK-logo.png');
        break;
      case "GHB":
        return AssetImage('assests/images/GHB-logo.jpg');
        break;
      case "GSB":
        return AssetImage('assests/images/GSB-logo.jpg');
        break;

      default:
        return null;
    }
  }

  Future<List<RecentTransactionModelResponse>> getRecentTransactions() async {
    List<RecentTransactionModelResponse> getRecentTransactionsList = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetRecentTransactions: ' + reqRefNo);
    RecentTransactionRequest request =
        RecentTransactionRequest(reqRefNo: reqRefNo);
    await recentTransactionConnect
        .connectRecentTransaction(request, globals.token)
        .then((value) {
      //print('status code GetRecentTransactions= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        RecentTransactionResponse response =
            RecentTransactionResponse.fromJson(responseMap);
        print("respDescGetRecentTransactions: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (RecentTransactionModelResponse data in response.listRecentTrn) {
           
            getRecentTransactionsList.add(data);

          }
          
        }
      }
    });
    return getRecentTransactionsList;
  }
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xFFeaecf0),
        appBar: _buildAppBar(context, _height),
        body: Stack(
          children: [
            Container(
              //padding: EdgeInsets.only(left: _height*0.02, right: _height*0.02, top: _height*0.02),
              height: _height,
              width: _width,
              child: Column(children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        left: _height * 0.02, right: _height * 0.02),
                    width: _width,
                    height: _height * 0.06,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        _buildButtomHistory(context),
                        SizedBox(
                          width: _height * 0.03,
                        ),
                        _buildButtomStatement(context)
                      ],
                    )),
                SizedBox(
                  height: _height * 0.015,
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _height * 0.08,
                  left: _height * 0.01,
                  right: _height * 0.01),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    alignment: Alignment.bottomCenter,
                    width: _width,
                    height: _height,
                    child: _buildDataHistory(context)),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget _buildDataButtomSheet(BuildContext context) {
  //   final double _height = MediaQuery.of(context).size.height;
  //   final double _width = MediaQuery.of(context).size.width;
  //   return Padding(
  //     padding: EdgeInsets.only(
  //         top: _height * 0.02, left: _height * 0.06, right: _height * 0.06),
  //     child: Container(
  //       width: _width,
  //       height: _height * 0.3,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Text(
  //                 'เลือกวันเริ่มต้น',
  //                 style: TextStyle(fontSize: _height * 0.026),
  //               ),
  //               Row(
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.only(
  //                         left: _height * 0.02, right: _height * 0.02),
  //                     alignment: Alignment.center,
  //                     width: _width * 0.4,
  //                     height: _height * 0.05,
  //                     decoration:
  //                         BoxDecoration(border: Border.all(color: Colors.grey)),
  //                     child: Text(
  //                       "${selectedDate.toLocal()}".split(' ')[0],
  //                       style: TextStyle(fontSize: _height * 0.023),
  //                     ),
  //                   ),
  //                   IconButton(
  //                       onPressed: () {
  //                         _selectDate(context);
                          
  //                       },
  //                       icon: Icon(
  //                         Icons.calendar_today,
  //                         color: Color(0xFF3b074b),
  //                       ))
  //                 ],
  //               )
  //             ],
  //           )

  //           // Text("${selectedDate.toLocal()}".split(' ')[0]),
  //           //   SizedBox(height: 20.0,),
  //           // RaisedButton(
  //           //   onPressed: () => _selectDate(context),
  //           //   child: Text('Select date'),
  //           // ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildDataHistory(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<RecentTransactionModelResponse>>(
      future: getRecentTransactions(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else{
          var data = snapshot.data;
          int lengthData =data.length;
          return lengthData>0?ListView.builder(
        itemCount: lengthData,
        itemBuilder: (context, int index) {
          return Card(
            child: Container(
              width: _width,
              height: _height * 0.14,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: _width * 0.18,
                    height: _height,
                    child: CircleAvatar(
                      radius: _height * 0.04,
                      backgroundImage: func.checkLogoBank(data[index].trfBotBankName),
                    ),
                  ),
                  Container(
                    width: _width * 0.73,
                    height: _height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(data[index].lkTransferTypeDes,
                            style: TextStyle(
                              fontSize: _height * 0.023,
                              color: Color(0xFF2a2a39),
                            )),
                        Text('ปลายทาง ' + data[index].trfAcctNo,
                            style: TextStyle(
                              fontSize: _height * 0.023,
                              color: Color(0xFF2a2a39),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('จำนวนเงิน ',
                                style: TextStyle(
                                  fontSize: _height * 0.023,
                                  color: Color(0xFF2a2a39),
                                )),
                            Text('${formatMoney.format(data[index].amount)}',
                                style: TextStyle(
                                  fontSize: _height * 0.028,
                                  color: Colors.green,
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(),
                            Text(Jiffy(data[index].dateTime).yMMMMEEEEdjm,
                                style: TextStyle(
                                  fontSize: _height * 0.02,
                                  color: Colors.grey,
                                ))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ):Center(child: Text('ไม่มีข้อมูล', style: TextStyle(fontSize: _height*0.026),),);
        }
      },
          
    );
  }

  Widget _buildButtomStatement(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        setState(() {
          visibilityHistory = false;
          visibilityStatement = true;
        });
        Navigator.pushNamed(context, PageTo.statementScreen);
      },
      child: Container(
          alignment: Alignment.center,
          height: _height,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: visibilityStatement == true
                          ? Color(0xFFe09a16)
                          : Colors.transparent,
                      width: _height * 0.005))),
          child: Text(
            'statement',
            style: TextStyle(fontSize: _height * 0.026),
          )),
    );
  }

  Widget _buildButtomHistory(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        setState(() {
          visibilityHistory = true;
          visibilityStatement = false;
        });
      },
      child: Container(
          alignment: Alignment.center,
          height: _height,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: visibilityHistory == true
                          ? Color(0xFFe09a16)
                          : Colors.transparent,
                      width: _height * 0.005))),
          child: Text(
            'รายการล่าสุด',
            style: TextStyle(fontSize: _height * 0.026),
          )),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    double _height,
  ) {
    return AppBar(
        backgroundColor: Color(0xFF3b074b),
        centerTitle: true,
        title: Text(
          'ประวัติการทำรายการ',
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }

  
}
