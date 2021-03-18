import 'dart:convert';

import 'package:corperate_banking/global_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rest_package/bean/checker_bean/checker_history_detail_request.dart';
import 'package:rest_package/bean/checker_bean/checker_history_detail_response.dart';
import 'package:rest_package/connection/checker_connection/checker_history_detail_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;


class HistoryCheckerOrderScreen extends StatefulWidget {
  String tracNo;
  HistoryCheckerOrderScreen({this.tracNo});
  @override
  _HistoryCheckerOrderScreenState createState() =>
      _HistoryCheckerOrderScreenState(tracNo: tracNo);
}

class _HistoryCheckerOrderScreenState extends State<HistoryCheckerOrderScreen> {
  FunctionGlobal func = FunctionGlobal();
  String tracNo;
  _HistoryCheckerOrderScreenState({this.tracNo});
  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  XSignature randReqRefNo = XSignature();
  CheckerHistoryDetailConnection checkerHistoryDetailConnect =
      CheckerHistoryDetailConnection(globals.iPV4, '8080');
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:");
  checkStatus(String status) {
    final double _height = MediaQuery.of(context).size.height;
    switch (status) {
      case 'Approved':
        return Text('อนุมัติแล้ว',
            style: TextStyle(
              fontSize: _height * 0.030,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ));
        break;
      case 'Waiting for Check':
        return Text('รายการรอการตรวจสอบ',
            style: TextStyle(
              fontSize: _height * 0.030,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ));
        break;
      case 'Waiting for Approval':
        return Text('ตรวจสอบเรียบร้อย',
            style: TextStyle(
              fontSize: _height * 0.030,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ));
        break;
      case 'Cancle By Maker':
        return Text('รายการยกเลิกโดยผู้สร้างรายการ',
            style: TextStyle(
              fontSize: _height * 0.030,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ));

        break;
      case 'Cancle By Checker':
        return Text('รายการยกเลิกโดยผู้ตรวจสอบ',
            style: TextStyle(
              fontSize: _height * 0.030,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ));
        break;
      case 'Cancle By Authorizer':
        return Text('รายการยกเลิกโดยผู้อนุมัติ',
            style: TextStyle(
              fontSize: _height * 0.030,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ));
        break;
      default:
    }
  }
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

    }
  }

  Future<CheckerHistoryDetailResponse> getCheckerHistoryDetail() async {
    CheckerHistoryDetailResponse res = new CheckerHistoryDetailResponse();
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefGetgetCheckerHistoryDetail: ' + reqRefNo);
    CheckerHistoryDetailRequest request =
        CheckerHistoryDetailRequest(reqRefNo: reqRefNo, trace_No: tracNo );
    await checkerHistoryDetailConnect
        .connectCheckerHistoryDetail(request, globals.token)
        .then((value) {
      //print('status code getCheckerHistoryDetail= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: '+value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        CheckerHistoryDetailResponse response =
            CheckerHistoryDetailResponse.fromJson(responseMap);
        print("respDescGetgetCheckerHistoryDetail: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          res.traceNo = response.traceNo;
          res.dateTime = response.dateTime;
          res.sender_Account_No = response.sender_Account_No;
          res.bank_Name_Sender_Th = response.bank_Name_Sender_Th;
          res.bank_Name_Sender_En = response.bank_Name_Sender_En;
          res.bank_Name_Recipient = response.bank_Name_Recipient;
          res.recipient_account_No = response.recipient_account_No;
          res.recipient_account_No_name_Th =
              response.recipient_account_No_name_Th;
          res.recipient_account_No_name_En =
              response.recipient_account_No_name_En;
          res.amount = response.amount;
          res.note = response.note;
          res.fee = response.fee;
          res.name_Check = response.name_Check;
          res.sender_Account_Type = response.sender_Account_Type;
          res.trnStatus = response.trnStatus;
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
        appBar: _buildAppBar(context, _height),
        body: Stack(
          children: [
            Container(
              width: _width,
              height: _height,
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //         colors: [Colors.black, Color(0xFF3b074b)])),
            ),
            _buildData(context),
            
          ],
        ),
      ),
    );
  }

  Widget _buildData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return FutureBuilder<CheckerHistoryDetailResponse>(
      future: getCheckerHistoryDetail(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else{
          var data=snapshot.data;
          return Container(
        padding: EdgeInsets.only(left: _height * 0.03, right: _height * 0.03, top: _height*0.03),
        alignment: Alignment.topCenter,
        width: _width,
        height: _height,
        child: Container(
          padding: EdgeInsets.only(
              left: _height * 0.02, right: _height * 0.02, top: _height * 0.01),
          width: _width,
          height: _height * 0.63,
          child: Stack(
            children: [
              Container(
                width: _width,
                height: _height,
                child: Image.network('https://t3.ftcdn.net/jpg/02/49/42/16/360_F_249421624_COqIjrl5UpwB8RA3u3xJe2TGI1P0IGHL.jpg',fit: BoxFit.cover,)
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.01),
                    child: Text(
                      'รายการโอนเงิน ',
                      style: TextStyle(
                          fontSize: _height * 0.03,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.01),
                    child: Text(Jiffy(data.dateTime).yMMMMEEEEdjm,style: TextStyle(fontSize: _height*0.023),),
                  ),
                  Divider(thickness: _height*0.002,),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.02),
                    child: Column(
                      children: [
                        Row(children: <Widget>[
                          CircleAvatar( 
                            radius: _height*0.04,
                            backgroundImage: data.bank_Name_Sender_Th==null?
                            AssetImage('assests/images/avatar-circle.png'):
                            checkLogoBank(data.bank_Name_Sender_Th)
                          ),
                          SizedBox(width: _height*0.04,),
                          Column(
                            children: [
                              Text(data.sender_Account_Type,style: TextStyle(fontSize: _height*0.023,),),
                              Text(data.sender_Account_No,style: TextStyle(fontSize: _height*0.023,color: Colors.grey[600]),)
                            ],
                          ),
                          
                        ],),
                        Padding(
                          padding: EdgeInsets.only(left: _height*0.035),
                          child: Row(
                            children: [
                              Container(
                                height: _height*0.1,
                                width: _width*0.01,
                                color: Color(0xFF3b074b),
                              ),
                              SizedBox(width: _height*0.04,),
                              Icon(Icons.arrow_downward,color: Color(0xFF3b074b),)
                            ],
                          ),
                        ),
                        Row(children: <Widget>[
                          CircleAvatar( 
                            radius: _height*0.04,
                            backgroundImage: data.bank_Name_Recipient==null?
                            AssetImage('assests/images/avatar-circle.png'):
                            checkLogoBank(data.bank_Name_Recipient)
                          ),
                          SizedBox(width: _height*0.04,),
                          Column(
                            children: [
                              Text(data.recipient_account_No_name_Th,style: TextStyle(fontSize: _height*0.023,),),
                              Text(data.recipient_account_No,style: TextStyle(fontSize: _height*0.023,color: Colors.grey[600]),)
                            ],
                          ),
                          
                        ],),
                        

                      ],
                    ),
                  ),
                  SizedBox(height: _height*0.03,),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.03, right: _height*0.03),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('เลขที่รายการ:',style: TextStyle(fontSize: _height*0.024,),),
                      Text(data.traceNo,style: TextStyle(fontSize: _height*0.023,color: Colors.grey[600]),)
                    ],),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.03, right: _height*0.03),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('จำนวนเงิน:',style: TextStyle(fontSize: _height*0.024,),),
                      Row(
                        children: [
                          Text('${formatMoney.format(data.amount)}',style: TextStyle(fontSize: _height*0.03,color: Colors.grey[600]),),
                          Text(' บาท',style: TextStyle(fontSize: _height*0.024,),)
                        ],
                      )
                    ],),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.03, right: _height*0.03),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('ค่าธรรมเนียม:',style: TextStyle(fontSize: _height*0.024,),),
                      Row(
                        children: [
                          Text('${formatMoney.format(data.fee)}',style: TextStyle(fontSize: _height*0.03,color: Colors.grey[600]),),
                          Text(' บาท',style: TextStyle(fontSize: _height*0.024,),)
                        ],
                      )
                    ],),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.03, right: _height*0.03),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('บันทึก:',style: TextStyle(fontSize: _height*0.024,),),
                      Text( data.note==null?' ':data.note,style: TextStyle(fontSize: _height*0.024,color: Colors.grey[600]),),
                    ],),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.03, right: _height*0.03),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('สถานะ:',style: TextStyle(fontSize: _height*0.024,),),
                      checkStatus(data.trnStatus)
                    ],),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.03, right: _height*0.03),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('ผู้ตรวจสอบ:',style: TextStyle(fontSize: _height*0.024,),),
                      Text(data.name_Check,style: TextStyle(fontSize: _height*0.024,color: Colors.grey[600]),)
                    ],),
                  ),
                  
                ],
              ),
              
            ],
          ),
        ),
      );
        }
      },
          
    );
  }

  Widget _buildAppBar(BuildContext context, double _height) {
    return AppBar(
      backgroundColor: Color(0xFF3b074b),
      centerTitle: true,
      leading: func.appBarPop(context),
      title: Text(
        'เลขที่รายกาาร: ' + tracNo,
        style: TextStyle(fontSize: _height * 0.03),
      ),
    );
  }

  // Widget _buildData(BuildContext context) {
  //   final double _height = MediaQuery.of(context).size.height;
  //   final double _width = MediaQuery.of(context).size.width;
  //   return FutureBuilder<CheckerHistoryDetailResponse>(
  //     future: getCheckerHistoryDetail(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       } else {
  //         var data = snapshot.data;
  //         return Container(
  //           padding:
  //               EdgeInsets.only(left: _height * 0.01, right: _height * 0.01),
  //           height: _height * 0.56,
  //           width: _width,
  //           child: Column(
  //             children: <Widget>[
  //               Container(
  //                 alignment: Alignment.center,
  //                 child: Text(
  //                   'รายการการโอน',
  //                   style: TextStyle(
  //                       fontSize: _height * 0.04, fontWeight: FontWeight.w300),
  //                 ),
  //               ),
  //               Container(
  //                 alignment: Alignment.center,
  //                 child: Text(
  //                   data.dateTime,
  //                   style: TextStyle(
  //                       fontSize: _height * 0.023, color: Colors.grey),
  //                 ),
  //               ),
  //               Container(
  //                 width: _width,
  //                 height: _height * 0.17,
  //                 child: Column(
  //                   children: <Widget>[
  //                     Container(
  //                       width: _width,
  //                       height: _height * 0.075,
  //                       child: Row(
  //                         children: <Widget>[
  //                           Container(
  //                             child: Text(
  //                               'จาก',
  //                               style: TextStyle(fontSize: _height * 0.023),
  //                             ),
  //                             width: _width * 0.1,
  //                             height: _height,
  //                             alignment: Alignment.centerLeft,
  //                           ),
  //                           Container(
  //                             width: _width * 0.15,
  //                             height: _height,
  //                             alignment: Alignment.centerLeft,
  //                             child: CircleAvatar(
  //                               backgroundImage: data.bank_Name_Sender_Th ==
  //                                       null
  //                                   ? AssetImage(
  //                                       'assests/images/avatar-circle.png')
  //                                   : checkLogoBank(data.bank_Name_Sender_Th),
  //                               backgroundColor: Colors.yellow,
  //                               radius: _height * 0.03,
  //                             ),
  //                           ),
  //                           Container(
  //                             width: _width * 0.55,
  //                             height: _height,
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: <Widget>[
  //                                 SizedBox(
  //                                   height: _height * 0.01,
  //                                 ),
  //                                 Text(
  //                                   data.sender_Account_Type == null
  //                                       ? 'บัญชีพร้อมเพย์'
  //                                       : data.sender_Account_Type,
  //                                   style: TextStyle(fontSize: _height * 0.018),
  //                                 ),
  //                                 Text(
  //                                   data.sender_Account_No,
  //                                   style: TextStyle(
  //                                       fontSize: _height * 0.015,
  //                                       color: Colors.grey),
  //                                 ),
  //                               ],
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     Container(
  //                       width: _width,
  //                       height: _height * 0.09,
  //                       child: Row(
  //                         children: <Widget>[
  //                           Container(
  //                             child: Text(
  //                               'ถึง',
  //                               style: TextStyle(fontSize: _height * 0.023),
  //                             ),
  //                             width: _width * 0.1,
  //                             height: _height,
  //                             alignment: Alignment.centerLeft,
  //                           ),
  //                           Container(
  //                             width: _width * 0.15,
  //                             height: _height,
  //                             alignment: Alignment.centerLeft,
  //                             child: CircleAvatar(
  //                               backgroundImage: data.bank_Name_Recipient ==
  //                                       null
  //                                   ? AssetImage(
  //                                       'assests/images/avatar-circle.png')
  //                                   : checkLogoBank(data.bank_Name_Recipient),
  //                               backgroundColor: Colors.yellow,
  //                               radius: _height * 0.03,
  //                             ),
  //                           ),
  //                           Container(
  //                             width: _width * 0.55,
  //                             height: _height,
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: <Widget>[
  //                                 SizedBox(
  //                                   height: _height * 0.01,
  //                                 ),
  //                                 Text(
  //                                   data.recipient_account_No_name_Th,
  //                                   style: TextStyle(fontSize: _height * 0.018),
  //                                 ),
  //                                 // Text(
  //                                 //   'ธนาคารไทยพาณิชย์',
  //                                 //   style: TextStyle(
  //                                 //       fontSize: _height * 0.015,
  //                                 //       color: Colors.grey),
  //                                 // ),
  //                                 Text(
  //                                   data.recipient_account_No,
  //                                   style: TextStyle(
  //                                       fontSize: _height * 0.015,
  //                                       color: Colors.grey),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Column(
  //                 children: <Widget>[
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: <Widget>[
  //                       Container(
  //                         child: Text(
  //                           'เลขที่รายการ :',
  //                           style: TextStyle(fontSize: _height * 0.023),
  //                         ),
  //                       ),
  //                       Container(
  //                         child: Text(
  //                           data.traceNo,
  //                           style: TextStyle(fontSize: _height * 0.03),
  //                         ),
  //                       )
  //                     ],
  //                   )
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Container(
  //                     child: Text(
  //                       'จำนวนเงิน :',
  //                       style: TextStyle(fontSize: _height * 0.023),
  //                     ),
  //                   ),
  //                   Container(
  //                     child: Text(
  //                       '${formatMoney.format(data.amount)}' + ' บาท',
  //                       style: TextStyle(fontSize: _height * 0.03),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Container(
  //                     child: Text(
  //                       'ค่าธรรมเนียม :',
  //                       style: TextStyle(fontSize: _height * 0.023),
  //                     ),
  //                   ),
  //                   Container(
  //                     child: Text(
  //                       '${formatMoney.format(data.fee)}' + ' บาท',
  //                       style: TextStyle(fontSize: _height * 0.03),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Container(
  //                     child: Text(
  //                       'บันทึก :',
  //                       style: TextStyle(fontSize: _height * 0.023),
  //                     ),
  //                   ),
  //                   Container(
  //                     child: Text(
  //                       data.note == null ? '' : data.note,
  //                       style: TextStyle(fontSize: _height * 0.018),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Container(
  //                     child: Text(
  //                       'สถานะการทำรายการ :',
  //                       style: TextStyle(fontSize: _height * 0.023),
  //                     ),
  //                   ),
  //                   Container(
  //                     child: Text(
  //                       data.trnStatus,
  //                       style: TextStyle(fontSize: _height * 0.018),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Container(
  //                     child: Text(
  //                       'ผู้ตรวจสอบ :',
  //                       style: TextStyle(fontSize: _height * 0.023),
  //                     ),
  //                   ),
  //                   Container(
  //                     child: Text(
  //                       data.name_Check,
  //                       style: TextStyle(fontSize: _height * 0.018),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }
}
