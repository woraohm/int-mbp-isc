import 'dart:convert';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screen_auth/checker_screen/checker_check_screen/checker_check_success_screen.dart';
import 'package:corperate_banking/screens/screen_auth/checker_screen/checker_check_screen/checker_reason_not_pass.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rest_package/bean/checker_bean/checker_check_order_request.dart';
import 'package:rest_package/bean/checker_bean/checker_check_order_response.dart';
import 'package:rest_package/bean/transf_order_detail_request.dart';
import 'package:rest_package/bean/transf_order_detail_response.dart';
import 'package:rest_package/connection/checker_connection/checker_check_order_connection.dart';
import 'package:rest_package/connection/transf_order_detail_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/model/transf_order_detail_model_response.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:corperate_banking/global/global.dart' as globals;

class CheckerCheckingScreen extends StatefulWidget {
  String tracNo;
  CheckerCheckingScreen({this.tracNo});
  @override
  _CheckerCheckingScreenState createState() =>
      _CheckerCheckingScreenState(tracNo: tracNo);
}

class _CheckerCheckingScreenState extends State<CheckerCheckingScreen> {
  FunctionGlobal func = FunctionGlobal();
  String tracNo;
  _CheckerCheckingScreenState({this.tracNo});
  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  XSignature randReqRefNo = XSignature();
  TransfOrderDetailConnection transfOrderDetailConnect =
      TransfOrderDetailConnection(globals.iPV4, '8080');
  CheckerCheckOrderConnection checkerCheckOrderConnect =
      CheckerCheckOrderConnection(globals.iPV4, '8080');
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
      case "ไม่มีธนาคาร":
        return AssetImage('assests/images/avatar-circle.png');
        break;

      default:
        return AssetImage('assests/images/avatar-circle.png');break;
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

  Future<void> checkerCheckOK(String tracNo) async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoCheckerCheckOK: ' + reqRefNo);
    CheckerCheckOrderRequest request = CheckerCheckOrderRequest(
        actionCode: "Approve", note: null, trace_No: tracNo, reqRefNo: reqRefNo);
    await checkerCheckOrderConnect
        .connectCheckerCheckOrder(request, globals.token)
        .then((value) {
      //print('status code CheckerCheckOK= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        CheckerCheckOrderResponse response =
            CheckerCheckOrderResponse.fromJson(responseMap);
        print("respDescCodeCheckerCheckOK: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
            
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CheckerCheckOrederSuccessScreen(
                        data: response,
                      )));
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "ระบบได้บันทึกข้อมูลของท่านเรียบร้อย",
              textStyle: TextStyle(fontSize: 20),
            ),
          );
        }
      }
    });
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
          res.lk_acct_type_name = response.lk_acct_type_name;
          res.traceNo = response.traceNo;
          res.trnStatus = response.trnStatus;
          res.bank_Name_Recipient = response.bank_Name_Recipient;
          res.bank_Name_Sender = response.bank_Name_Sender;
          res.amount = response.amount;
        }
      }
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()=>func.onBackPressed(context),
          child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(context, _height),
          backgroundColor: Color(0xFFeaecf0),
          body: FutureBuilder<TransfOrderDetailModelResponse>(
            future: getOrderDetail(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var data = snapshot.data;
                return Container(
                  height: _height,
                  width: _width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: _height * 0.01,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: _height * 0.02),
                          child: Text(
                            'รายละเอียดการโอนเงิน',
                            style: TextStyle(fontSize: _height * 0.026),
                          )),
                      SizedBox(
                        height: _height * 0.01,
                      ),
                      Container(
                        color: Colors.white,
                        height: _height * 0.3,
                        width: _width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    left: _height * 0.02,
                                    right: _height * 0.02,
                                    top: _height * 0.01,
                                    bottom: _height * 0.01),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'จาก',
                                      style: TextStyle(fontSize: _height * 0.023),
                                    ),
                                    _buildFormData(
                                        context,
                                        data.sender_Account_No,
                                        data.bank_Name_Sender,
                                        data.lk_acct_type_name),
                                    SizedBox(
                                      height: _height * 0.01,
                                    ),
                                    Text(
                                      'ถึง',
                                      style: TextStyle(fontSize: _height * 0.023),
                                    ),
                                    _buildToData(
                                      context,
                                      data.recipient_account_No,
                                      data.recipient_account_No_name_Th,
                                      data.bank_Name_Recipient,
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.01,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: _height * 0.02),
                          child: Text(
                            'ยอดโอนเงิน',
                            style: TextStyle(fontSize: _height * 0.026),
                          )),
                      _buildAmount(context, data.amount),
                      SizedBox(
                        height: _height * 0.001,
                      ),
                      _buildFee(context, data.fee),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      _buildNote(context, data.note),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      _buildButtonConfirm(context, data.traceNo),
                      SizedBox(
                        height: _height * 0.008,
                      ),
                      _buildButtonCancle(context, data.traceNo)
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, double _height) {
    return AppBar(
      backgroundColor: Color(0xFF3b074b),
      centerTitle: true,
      leading: func.appBarPop(context),
      title: Text(
        'การตรวจสอบ: ' + tracNo,
        style: TextStyle(fontSize: _height * 0.03),
      ),
    );
  }

  Widget _buildFormData(
      BuildContext context, String acctNo, String bankName, String acctType) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: _height * 0.01),
      height: _height * 0.1,
      width: _width,
      color: Color(0xFF3b074b),
      child: Container(
        height: _height,
        width: _width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: checkLogoBank(bankName),
            radius: _height * 0.025,
          ),
          title: Text(
            acctType,
            style: TextStyle(fontSize: _height * 0.02),
          ),
          subtitle: Text(
            acctNo,
            style: TextStyle(fontSize: _height * 0.02),
          ),
        ),
      ),
    );
  }

  Widget _buildToData(
      BuildContext context, String acctNo, String acctName, String bankName) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    print(bankName);
    return Container(
      padding: EdgeInsets.only(left: _height * 0.01),
      height: _height * 0.1,
      width: _width,
      color: Color(0xFF3b074b),
      child: Container(
        height: _height,
        width: _width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: bankName == null
                ? AssetImage('assests/images/avatar-circle.png')
                : checkLogoBank(bankName),
            radius: _height * 0.025,
          ),
          title: Text(
            acctName,
            style: TextStyle(fontSize: _height * 0.02),
          ),
          subtitle: Text(
            acctNo,
            style: TextStyle(fontSize: _height * 0.018),
          ),
        ),
      ),
    );
  }

  Widget _buildAmount(BuildContext context, double amount) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
      height: _height * 0.08,
      width: _width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'จำนวนเงิน: ',
            style: TextStyle(fontSize: _height * 0.02),
          ),
          Text(
            '${formatMoney.format(amount)}' + ' บาท',
            style: TextStyle(fontSize: _height * 0.02),
          )
        ],
      ),
    );
  }

  Widget _buildFee(BuildContext context, double fee) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
      height: _height * 0.08,
      width: _width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'ค่าธรรมเนียม: ',
            style: TextStyle(fontSize: _height * 0.02),
          ),
          Text(
            '${formatMoney.format(fee)}' + ' บาท',
            style: TextStyle(fontSize: _height * 0.02),
          )
        ],
      ),
    );
  }

  Widget _buildNote(BuildContext context, String note) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
      height: _height * 0.08,
      width: _width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'บันทึก: ',
            style: TextStyle(fontSize: _height * 0.02),
          ),
          Text(
            note,
            style: TextStyle(fontSize: _height * 0.018),
          )
        ],
      ),
    );
  }

  Widget _buildButtonConfirm(BuildContext context, String tracNo) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: _height * 0.03, right: _height * 0.03),
      height: _height * 0.075,
      width: _width,
      child: InkWell(
        onTap: () {
          Alert(
            context: context,
            type: AlertType.success,
            title: "คุณต้องการดำเนินการต่อใช่หรือไม่",
            buttons: [
              DialogButton(
                color: Color(0xFF3b074b),
                child: Text(
                  "ตกลง",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  checkerCheckOK(tracNo);
                },
                width: 120,
              )
            ],
          ).show();
        },
        child: Card(
          elevation: 5,
          color: Color(0xFF3b074b),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            alignment: Alignment.center,
            height: _height,
            width: _width,
            child: Text(
              'ตรวจสอบเรียบร้อย',
              style: TextStyle(fontSize: _height * 0.026, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonCancle(BuildContext context, String tracNo) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: _height * 0.03, right: _height * 0.03),
      height: _height * 0.075,
      width: _width,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckerCheckNotPassReasonScreen(tracNo: tracNo,)));
        },
        child: Card(
          elevation: 5,
          color: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            alignment: Alignment.center,
            height: _height,
            width: _width,
            child: Text(
              'ไม่ผ่านการตรวจสอบ',
              style: TextStyle(fontSize: _height * 0.026, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
