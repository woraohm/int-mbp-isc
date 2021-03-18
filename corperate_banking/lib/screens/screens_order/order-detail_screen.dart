import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:rest_package/bean/transf_order_detail_request.dart';
import 'package:rest_package/bean/transf_order_detail_response.dart';
import 'package:rest_package/connection/transf_order_detail_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/model/transf_order_detail_model_response.dart';

class OrderDetailScreen extends StatefulWidget {
  String tracNo;
  OrderDetailScreen({this.tracNo});
  @override
  _OrderDetailScreenState createState() =>
      _OrderDetailScreenState(tracNo: tracNo);
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  String tracNo;
  _OrderDetailScreenState({this.tracNo});
  TransfOrderDetailConnection transfOrderDetailConnect =
      TransfOrderDetailConnection(globals.iPV4, '8080');
  XSignature randReqRefNo = XSignature();
  List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow
  ];
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];
  int index = 0;
  Color bottomColor = Colors.red;
  Color topColor = Colors.yellow;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

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
        return AssetImage('assests/images/avatar-circle.png');
        break;
    }
  }

  checkNameBankFromLogo(String bankName) {
    switch (bankName) {
      case "ไทยพาณิชย์":
        return "ธนาคารไทยพาณิชย์";
        break;
      case "กรุงเทพ":
        return "ธนาคารกรุงเทพ";
        break;
      case "กรุงไทย":
        return "ธนาคารกรุงไทย";
        break;
      case "กรุงศรีอยุธยา":
        return "ธนาคารกรุงศรีอยุธยา";
        break;
      case "กสิกรไทย":
        return "ธนาคารกสิกรไทย";
        break;
      case "ทหารไทย":
        return "ธนาคารทหารไทย";
        break;
      case "ธนชาติ":
        return "ธนาคารธนชาต";
        break;
      case "อาคารสงเคราะห์":
        return "ธนาคารอาคารสงเคราะห์";
        break;
      case "ออมสิน":
        return "ธนาคารออมสิน";
        break;

      default:
        return "null";
    }
  }

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
        return Text('รายการรออนุมัติ',
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

  Future<TransfOrderDetailModelResponse> getOrderDetail() async {
    TransfOrderDetailModelResponse res = new TransfOrderDetailModelResponse();
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetOrderDetail: ' + reqRefNo);
    TransfOrderDetailRequest request =
        TransfOrderDetailRequest(reqRefNo: reqRefNo, traceNo: tracNo);
    await transfOrderDetailConnect
        .transfOrderDetailConnection(request, globals.token)
        .then((value) {
      //print('status code GetOrderDetail= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfOrderDetailResponse response =
            TransfOrderDetailResponse.fromJson(responseMap);
        print("respDescCodeGetOrderDetail: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          res.dateTime = response.dateTime;
          res.fee = response.fee;
          res.note = response.note;
          res.recipient_account_No = response.recipient_account_No;
          res.recipient_account_No_name_En =
              response.recipient_account_No_name_En;
          res.recipient_account_No_name_Th =
              response.recipient_account_No_name_Th;
          res.sender_Account_No = response.sender_Account_No;
          res.traceNo = response.traceNo;
          res.trnStatus = response.trnStatus;
          res.bank_Name_Recipient = response.bank_Name_Recipient;
          res.bank_Name_Sender = response.bank_Name_Sender;
          res.amount = response.amount;
          res.lk_acct_type_name = response.lk_acct_type_name;
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
        backgroundColor: Color(0xFFeaecf0),
        appBar: _buildAppBar(context, _height),
        body: Container(
          width: _width,
          height: _height,
          child: FutureBuilder<TransfOrderDetailModelResponse>(
            future: getOrderDetail(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var data = snapshot.data;
                return Stack(
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          width: _width,
                          height: _height * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12)),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.black, Color(0xFF3b074b)]),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: _width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    _buildHeadData1(
                                        context,
                                        data.bank_Name_Sender,
                                        data.lk_acct_type_name,
                                        data.sender_Account_No,
                                        data.bank_Name_Recipient,
                                        data.recipient_account_No_name_Th,
                                        data.recipient_account_No),
                                    SizedBox(
                                      height: _height * 0.03,
                                    ),
                                    //_buildHeadData2(context),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.bottomCenter,
                            width: _width,
                            height: _height * 0.6,
                            child: Card(
                              elevation: 2,
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12))),
                              child: Container(
                                padding: EdgeInsets.only(top: _height * 0.02),
                                width: _width,
                                height: _height * 0.16,
                                child: _buildHeadData2(context, data.amount,
                                    data.fee, data.traceNo),
                              ),
                            )),
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: _width,
                      height: _height,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: _height * 0.02,
                            right: _height * 0.02,
                            top: _height * 0.02),
                        width: _width,
                        height: _height * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'บันทึก',
                              style: TextStyle(
                                  fontSize: _height * 0.030,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700]),
                            ),
                            SizedBox(
                              height: _height * 0.01,
                            ),
                            Card(
                                                          child: Container(
                                padding: EdgeInsets.only(left: _height * 0.02),
                                alignment: Alignment.centerLeft,
                                width: _width,
                                height: _height * 0.06,
                                color: Colors.grey[275],
                                child: Text(
                                  data.note == null ? '' : data.note,
                                  style: TextStyle(fontSize: _height * 0.024),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'สถานะรายการ:',
                                  style: TextStyle(
                                      fontSize: _height * 0.030,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]),
                                ),
                                checkStatus(data.trnStatus),
                              ],
                            ),
                            SizedBox(
                              height: _height * 0.01,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeadData1(
      BuildContext context,
      String bankNameSender,
      String acctTypeSender,
      String acctNoSender,
      String bankNameRecipient,
      String acctNameRecipient,
      String acctNoRecipient) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.only(
            left: _height * 0.08, right: _height * 0.02, top: _height * 0.06),
        child: Container(
          width: _width,

          //color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    radius: _height * 0.05,
                    backgroundImage: bankNameSender == null
                        ? AssetImage('assests/images/avatar-circle.png')
                        : checkLogoBank(bankNameSender),
                  ),
                  SizedBox(
                    width: _height * 0.02,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        acctTypeSender,
                        style: TextStyle(
                            color: Color(0xFFe09a16),
                            fontSize: _height * 0.026),
                      ),
                      Text(
                        acctNoSender,
                        style: TextStyle(
                            color: Colors.white, fontSize: _height * 0.026),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: _height * 0.05,
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1),
                      onEnd: () {
                        setState(() {
                          index = index + 1;
                          // animate the color
                          bottomColor = colorList[index % colorList.length];
                          topColor = colorList[(index + 1) % colorList.length];

                          //// animate the alignment
                          // begin = alignmentList[index % alignmentList.length];
                          // end = alignmentList[(index + 2) % alignmentList.length];
                        });
                      },
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: begin,
                              end: end,
                              colors: [bottomColor, topColor])),
                      child: Container(
                          width: _width * 0.003,
                          height: _height * 0.15,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: _height * 0.02,
                    ),
                    Icon(
                      Icons.arrow_downward_outlined,
                      color: Colors.white,
                      size: _height * 0.06,
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: _height * 0.05,
                    backgroundImage: bankNameRecipient == null
                        ? AssetImage('assests/images/avatar-circle.png')
                        : checkLogoBank(bankNameRecipient),
                  ),
                  SizedBox(
                    width: _height * 0.02,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        acctNameRecipient,
                        style: TextStyle(
                            color: Color(0xFFe09a16),
                            fontSize: _height * 0.026),
                      ),
                      Text(
                        acctNoRecipient,
                        style: TextStyle(
                            color: Colors.white, fontSize: _height * 0.026),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildHeadData2(
      BuildContext context, double amount, double fee, String tracNo) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: _height * 0.06, right: _height * 0.06),
      child: Container(
        width: _width,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'จำนวนเงิน:',
                  style:
                      TextStyle(color: Colors.white, fontSize: _height * 0.026),
                ),
                Text('${formatMoney.format(amount)}',
                    style: TextStyle(
                        color: Colors.white, fontSize: _height * 0.028))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'ค่าธรรมเนียม:',
                  style:
                      TextStyle(color: Colors.white, fontSize: _height * 0.026),
                ),
                Text('${formatMoney.format(fee)}',
                    style: TextStyle(
                        color: Colors.white, fontSize: _height * 0.028))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'เลขที่รายการ:',
                  style:
                      TextStyle(color: Colors.white, fontSize: _height * 0.026),
                ),
                Text(tracNo,
                    style: TextStyle(
                        color: Colors.white, fontSize: _height * 0.028))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    double _height,
  ) {
    return AppBar(
        backgroundColor: Color(0xFF3b074b),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'รายละเอียดรายการ',
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }
}
