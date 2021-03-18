import 'dart:convert';
import 'dart:ui';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:rest_package/bean/checker_bean/checker_check_order_request.dart';
import 'package:rest_package/bean/checker_bean/checker_check_order_response.dart';
import 'package:rest_package/connection/checker_connection/checker_check_order_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:corperate_banking/global/global.dart' as globals;

class CheckerCheckNotPassReasonScreen extends StatefulWidget {
  String tracNo;
  CheckerCheckNotPassReasonScreen({this.tracNo});
  @override
  _CheckerCheckNotPassReasonScreenState createState() =>
      _CheckerCheckNotPassReasonScreenState(tracNo: tracNo);
}


class _CheckerCheckNotPassReasonScreenState
    extends State<CheckerCheckNotPassReasonScreen> {
      FunctionGlobal func = FunctionGlobal();
String tracNo;
_CheckerCheckNotPassReasonScreenState({this.tracNo});
TextEditingController noteController = TextEditingController();
 XSignature randReqRefNo = XSignature();
 CheckerCheckOrderConnection checkerCheckOrderConnect =
      CheckerCheckOrderConnection(globals.iPV4, '8080');



  Future<void> checkerCheckCancle(String tracNo) async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoCheckerCheckCancle: ' + reqRefNo);
    CheckerCheckOrderRequest request = CheckerCheckOrderRequest(
        actionCode: "Reject", note: noteController.text, trace_No: tracNo, reqRefNo: reqRefNo);
    await checkerCheckOrderConnect
        .connectCheckerCheckOrder(request, globals.token)
        .then((value) {
      //print('status code CheckerCheckCancle= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        CheckerCheckOrderResponse response =
            CheckerCheckOrderResponse.fromJson(responseMap);
        print("respDescCodeCheckerCheckCancle: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
            
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "ระบบได้บันทึกข้อมูลของท่านเรียบร้อย",
              textStyle: TextStyle(fontSize: 20),
            ),
          );
               Navigator.of(context).popUntil(ModalRoute.withName(PageTo.checkerOrderScreen));
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()=>func.onBackPressed(context),
          child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: Stack(
            children: <Widget>[
              _buildBackgroundImageBlur(context),
              _buildTextFormFiledReason(context),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: _height * 0.4,
                  ),
                  _buildButtonCheckedReson(context)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonCheckedReson(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
      child: InkWell(
        onTap: (){
          checkerCheckCancle(tracNo);
        },
              child: Card(
          elevation: 5,
          color: Color(0xFF3b074b),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Container(
            alignment: Alignment.center,
            width: _width,
            height: _height * 0.07,
            child: Text('เรียบร้อย',style: TextStyle(fontSize: _height*0.024,color: Colors.white),),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormFiledReason(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
      width: _width,
      height: _height,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: _height * 0.1,
          ),
          Container(
            width: _width,
            height: _height * 0.2,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(left: _height * 0.01),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'กรุณาบอกเหตุผลที่ไม่ผ่านการตรวจสอบ',
                        style: TextStyle(fontSize: _height * 0.023),
                      )),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: _height * 0.01, right: _height * 0.01),
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(
                        left: _height * 0.01, right: _height * 0.01),
                    width: _width,
                    height: _height * 0.1,
                    decoration:
                        BoxDecoration(border: Border.all(color: Color(0xFF3b074b))),
                    child: TextFormField(
                      controller: noteController,
                      style: TextStyle(fontSize: _height * 0.02),
                      maxLines: 2,
                      maxLength: 50,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: _height * 0.023),
                          enabledBorder: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: _height * 0.02),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'บอกเหตุผลได้ที่นี่'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImageBlur(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      color: Color(0xFFeaecf0),

      
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return AppBar(
        backgroundColor: Color(0xFF3b074b),
        centerTitle: true,
        title: Text(
          'รายการ: ' + tracNo,
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }
}
