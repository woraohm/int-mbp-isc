import 'dart:convert';

import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rest_package/bean/logout_request.dart';
import 'package:rest_package/bean/logout_response.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/connection/logout_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

const backgroundMainColor = Color(0xFF3b074b);
const backgroundColor = Color(0xFFeaecf0);
final formatMoney = new NumberFormat("#,##0.00", "en_US");

class FunctionGlobal {
  XSignature randReqRefNo = XSignature();
  LogoutConnection logout = LogoutConnection(globals.iPV4, '8080');
  Future<bool> onBackPressed(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Are you sure?',
              style: TextStyle(fontSize: _height * 0.03),
            ),
            content: Text(
              'Do you want to exit an App',
              style: TextStyle(fontSize: _height * 0.024),
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Container(
                    color: Colors.grey,
                    padding: EdgeInsets.only(
                        left: _height * 0.01, right: _height * 0.01),
                    child: Text(
                      "NO",
                      style: TextStyle(
                          fontSize: _height * 0.023, color: Colors.white),
                    )),
              ),
              SizedBox(height: 16),
              GestureDetector(
                  onTap: () => SystemNavigator.pop(),
                  child: Container(
                      color: Color(0xFF3b074b),
                      padding: EdgeInsets.only(
                          left: _height * 0.01, right: _height * 0.01),
                      child: Text(
                        "YES",
                        style: TextStyle(
                          fontSize: _height * 0.023,
                          color: Colors.white,
                        ),
                      ))),
            ],
          ),
        ) ??
        false;
  }

  Widget appBarPop(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.pop(context),
    );
  }

  Widget buildAppBar(BuildContext context, String name) {
    final double _height = MediaQuery.of(context).size.height;
    return AppBar(
      centerTitle: true,
      leading: appBarPop(context),
      title: Text(
        name,
        style: TextStyle(
          fontSize: _height * 0.03,
          color: Colors.white,
        ),
      ),
      backgroundColor: backgroundMainColor,
    );
  }

  Widget buildTextMain(BuildContext context, String text) {
    final double _height = MediaQuery.of(context).size.height;

    return Text(
      text,
      style: TextStyle(fontSize: _height * 0.024),
    );
  }

  Future<void> logOut(BuildContext context) async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefLogout: ' + reqRefNo);
    LogoutRequest request = LogoutRequest(reqRefNo: reqRefNo);
    await logout.connectLogout(request, globals.token).then((value) {
      //print('status code Logout= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        LogoutResponse response = LogoutResponse.fromJson(responseMap);
        print('resDescLogout: ' + response.respDesc);
        if (response.respCode == ResponseCode.APPROVED) {
          Navigator.popAndPushNamed(context, PageTo.loginScreen);
          globals.token = null;
          globals.nameTHCompany = null;
          globals.staffEmail = null;
          globals.staffFname = null;
          globals.staffLname = null;
          globals.staffMobile = null;
          globals.staffProfile = null;
          globals.staffThem = null;
          globals.isLoggedIn = false;
          print('log out OK');
        }
      }
    });
  }

  checkStatus(BuildContext context, String status) {
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
      case "ไม่มีธนาคาร":
        return AssetImage('assests/images/avatar-circle.png');
        break;

      default:
        return AssetImage('assests/images/avatar-circle.png');
        break;
    }
  }

  showAlert(BuildContext context, String message) {
    return Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: "ERROR!",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "ตกลง",
            style: TextStyle(color: Colors.white, fontSize: 20, ),
          ),
          onPressed: () => Navigator.pop(context),
          color: backgroundMainColor,
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  var alertStyle = AlertStyle(
    animationType: AnimationType.grow,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    //descStyle: TextStyle(fontWeight: FontWeight.bold),
    descTextAlign: TextAlign.center,
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
      fontSize: 24,
      fontWeight: FontWeight.w500
    ),
    alertAlignment: Alignment.center,
  );
  
  

}
