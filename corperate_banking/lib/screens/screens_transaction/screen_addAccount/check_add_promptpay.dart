import 'dart:convert';
import 'dart:ui';

import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:rest_package/bean/add_promptpay_other_request.dart';
import 'package:rest_package/bean/add_promptpay_other_response.dart';
import 'package:rest_package/connection/add_promptpay_other_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:corperate_banking/global/global.dart' as globals;

class CheckAddPromptpayScreen extends StatefulWidget {
  String promptpayNumber;
  String promptpayName;
  CheckAddPromptpayScreen({
    this.promptpayNumber,
    this.promptpayName
  });
  @override
  _CheckAddPromptpayScreenState createState() => _CheckAddPromptpayScreenState(promptpayNumber: promptpayNumber, promptpayName: promptpayName);
}

class _CheckAddPromptpayScreenState extends State<CheckAddPromptpayScreen> {
  String promptpayNumber;
   String promptpayName;
  _CheckAddPromptpayScreenState({
    this.promptpayNumber,
    this.promptpayName
  });

  XSignature randReqRefNo = XSignature();
  AddPromptpayOtherConnection addPromptpayConnect = AddPromptpayOtherConnection(globals.iPV4, '8080');


  Future<void>addPromptpayNow()async{
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoAddPromptpayNow: ' + reqRefNo);
    AddPromptpayOtherRequest request = AddPromptpayOtherRequest(reqRefNo: reqRefNo, prompt_Pay_No: promptpayNumber,acctName: promptpayName);
    await addPromptpayConnect.connectAddPromptpayOther(request, globals.token).then((value){
        //print('status code AddPromptpayNow= ' + value.statusCode.toString());
        if (value.statusCode == 200){
          //print('body: ' + value.body);
          Map<String, dynamic> responseMap = jsonDecode(value.body);
          AddPromptpayOtherResponse response = AddPromptpayOtherResponse.fromJson(responseMap);
          print("respDescCodeAddPromptpayNow: " + response.respDesc);
          if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED){
                 print('add promptpay account success');
                      showTopSnackBar(
                        context,
                        CustomSnackBar.success(
                          message: "เพิ่มบัญชีพร้อมเพย์สำเร็จ",
                          textStyle: TextStyle(fontSize: 20),
                        ),
                      );
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName(PageTo.indexScreen));
            }else{
              print('add promptpay error!!!');
              
            }
        }else{
          
          print('add connect promptpay error!!');
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Stack(
          children: <Widget>[
            _buildBackgroundImageBlur(context),
            Container(
              padding:
                  EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
              width: _width,
              height: _height,
              child: Column(
                children: [
                  SizedBox(
                    height: _height * 0.1,
                  ),
                  _buildCheckData(context),
                  SizedBox(
                    height: _height * 0.1,
                  ),
                  InkWell(
                    onTap: () {
                     addPromptpayNow();
                    },
                    child: Card(
                      color: Color(0xFF3b074b),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      child: Container(
                        alignment: Alignment.center,
                        width: _width,
                        height: _height * 0.08,
                        child: Text(
                          'เพิ่มบัญชี',
                          style: TextStyle(
                              fontSize: _height * 0.024, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      
      
    );
  }
  Widget _buildCheckData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        padding: EdgeInsets.only(left: _height * 0.01, right: _height * 0.01),
        width: _width,
        height: _height * 0.3,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _height * 0.02,
            ),
            Container(
              alignment: Alignment.center,
              width: _width,
              height: _height * 0.1,
              child: CircleAvatar(
                radius: _height * 0.05,
                backgroundImage: AssetImage('assests/images/avatar-circle.png'),
              ),
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
              ],
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'หมายเลขพร้อมเพย์',
                  style: TextStyle(fontSize: _height * 0.024),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    //width: _width*0.4,
                    padding: EdgeInsets.only(
                        left: _height * 0.02, right: _height * 0.02),
                    color: Colors.grey[300],
                    child: Text(
                      promptpayNumber,
                      style: TextStyle(fontSize: _height * 0.024),
                    ))
              ],
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'ชื่อบัญชี',
                  style: TextStyle(fontSize: _height * 0.024),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    //width: _width*0.4,
                    padding: EdgeInsets.only(
                        left: _height * 0.02, right: _height * 0.02),
                    color: Colors.grey[300],
                    child: Text(
                      promptpayName,
                      style: TextStyle(fontSize: _height * 0.024),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImageBlur(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      color: Color(0xFFF4F0F9),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return AppBar(
        backgroundColor: Color(0xFF3b074b),
        centerTitle: true,
        title: Text(
          'ตรวจสอบบัญชีพร้อมเพย์',
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }
}