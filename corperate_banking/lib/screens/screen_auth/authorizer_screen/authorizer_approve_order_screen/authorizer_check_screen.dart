import 'dart:convert';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screen_auth/authorizer_screen/authorizer_approve_order_screen/authorizer_approve_not_success_screen.dart';
import 'package:corperate_banking/screens/screen_auth/authorizer_screen/authorizer_approve_order_screen/authorizer_approve_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rest_package/bean/authorizor_bean/authorizer_approvel_order_request.dart';
import 'package:rest_package/bean/authorizor_bean/authorizer_approvel_order_response.dart';
import 'package:rest_package/bean/authorizor_bean/authorizer_check_transf_request.dart';
import 'package:rest_package/bean/authorizor_bean/authorizer_check_transf_response.dart';
import 'package:rest_package/connection/authorizer_connection/authorizer_approvel_order_connection.dart';
import 'package:rest_package/connection/authorizer_connection/authorizer_check_transf_connect.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:corperate_banking/global/global.dart' as globals;

class AuthorizerCheckScreen extends StatefulWidget {
  String tracNo;
  AuthorizerCheckScreen({this.tracNo});
  @override
  _AuthorizerCheckScreenState createState() =>
      _AuthorizerCheckScreenState(tracNo: tracNo);
}

class _AuthorizerCheckScreenState extends State<AuthorizerCheckScreen> {
  String tracNo;
  _AuthorizerCheckScreenState({this.tracNo});
  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  XSignature randReqRefNo = XSignature();
  AuthorizerCheckTransfConnection authorCheckTransfConnect =
      AuthorizerCheckTransfConnection(globals.iPV4, '8080');
  AuthorizerApprovelOrderConnection authorApprovelConnect = AuthorizerApprovelOrderConnection(globals.iPV4, '8080');
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
  Future<AuthorizerCheckTransfResponse> getAuthorizerCheckTransfOrder() async {
    AuthorizerCheckTransfResponse res = new AuthorizerCheckTransfResponse();
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetAuthorizerCheckTransfOrder: ' + reqRefNo);
    AuthorizerCheckTransfRequest request =
        AuthorizerCheckTransfRequest(reqRefNo: reqRefNo, traceNo: tracNo);
    await authorCheckTransfConnect
        .connectAuthorizerCheckTransf(request, globals.token)
        .then((value) {
      //print('status code GetAuthorizerCheckTransfOrder= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        AuthorizerCheckTransfResponse response =
            AuthorizerCheckTransfResponse.fromJson(responseMap);
        print(
            "respDescCodeGetAuthorizerCheckTransfOrder: " + response.respDesc);
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
  
  Future<void> authorizerApprovel(String tracNo) async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoauthorizerApprovel: ' + reqRefNo);
    AuthorizerApprovelOrderRequest request = AuthorizerApprovelOrderRequest(
        actionCode: "Approve", note: null, trace_No: tracNo, reqRefNo: reqRefNo);
    await authorApprovelConnect
        .connectAuthorizerApprovelOrder(request, globals.token)
        .then((value) {
      //print('status code authorizerApprovel= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
       
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        AuthorizerApprovelOrderResponse response =
            AuthorizerApprovelOrderResponse.fromJson(responseMap);
        print("respDescCodeauthorizerApprovel: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AuthorizerApproveSuccessScreen(
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

  Future<void> authorizerCheckCancle(String tracNo) async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoauthorizerCheckCancle: ' + reqRefNo);
    AuthorizerApprovelOrderRequest request = AuthorizerApprovelOrderRequest(
        actionCode: "Reject", note:null, trace_No: tracNo, reqRefNo: reqRefNo);
    await authorApprovelConnect
        .connectAuthorizerApprovelOrder(request, globals.token)
        .then((value) {
      //print('status code authorizerCheckCancle= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        AuthorizerApprovelOrderResponse response =
            AuthorizerApprovelOrderResponse.fromJson(responseMap);
        print("respDescCodeauthorizerCheckCancle: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AuthorizerApproveNotSuccessScreen(
                        data: response,
                      )));
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: "ยกเลิกรายการสำเร็จ",
              textStyle: TextStyle(fontSize: 20),
            ),
          );
          
           
        }
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, _height),
        backgroundColor: backgroundColor,
        body: FutureBuilder<AuthorizerCheckTransfResponse>(
          future: getAuthorizerCheckTransfOrder(),
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
                                  _buildFormData(context,data.bank_Name_Sender,data.lk_acct_type_name,data.sender_Account_No),
                                  SizedBox(
                                    height: _height * 0.01,
                                  ),
                                  Text(
                                    'ถึง',
                                    style: TextStyle(fontSize: _height * 0.023),
                                  ),
                                  _buildToData(context,data.bank_Name_Recipient,data.recipient_account_No_name_Th,data.recipient_account_No)
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
                    _buildButtonConfirm(context),
                    SizedBox(
                      height: _height * 0.008,
                    ),
                    _buildButtonCancle(context)
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    double _height,
  ) {
    return AppBar(
        backgroundColor: backgroundMainColor,
        centerTitle: true,
        title: Text(
          'รายการ: ' + tracNo,
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }

  Widget _buildFormData(BuildContext context,String bankName, String acctType, String acctNo) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: _height * 0.01),
      height: _height * 0.1,
      width: _width,
      color: backgroundMainColor,
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

  Widget _buildToData(BuildContext context,String bankName, String acctName, String acctNo) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: _height * 0.01),
      height: _height * 0.1,
      width: _width,
      color: backgroundMainColor,
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
            note==null?'':note,
            style: TextStyle(fontSize: _height * 0.018),
          )
        ],
      ),
    );
  }

  Widget _buildButtonConfirm(BuildContext context) {
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
                color: backgroundMainColor,
                child: Text(
                  "ตกลง",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  
                  authorizerApprovel(tracNo);
                  
                },
                width: 120,
              )
            ],
          ).show();
        },
        child: Card(
          elevation: 5,
          color: backgroundMainColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            alignment: Alignment.center,
            height: _height,
            width: _width,
            child: Text(
              'อนุมัติ',
              style: TextStyle(fontSize: _height * 0.026, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonCancle(BuildContext context) {
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
            type: AlertType.error,
            title: "คุณต้องการดำเนินการต่อใช่หรือไม่",
            buttons: [
              DialogButton(
                color: backgroundMainColor,
                child: Text(
                  "ตกลง",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  authorizerCheckCancle(tracNo);
                 
                },
                width: 120,
              )
            ],
          ).show();
        },
        child: Card(
          elevation: 5,
          color: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            alignment: Alignment.center,
            height: _height,
            width: _width,
            child: Text(
              'ไม่อนุมัติ',
              style: TextStyle(fontSize: _height * 0.026, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
