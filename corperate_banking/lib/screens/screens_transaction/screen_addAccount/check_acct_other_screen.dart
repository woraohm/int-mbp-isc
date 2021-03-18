import 'dart:convert';
import 'dart:ui';

import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:rest_package/bean/add_other_user_acct_request.dart';
import 'package:rest_package/bean/add_other_user_acct_response.dart';
import 'package:rest_package/bean/check_add_acct_other_request.dart';
import 'package:rest_package/bean/check_add_acct_other_response.dart';
import 'package:rest_package/connection/add_other_user_acct_connection.dart';
import 'package:rest_package/connection/check_add_acct_other_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/model/check_add_acct_other_model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:corperate_banking/global/global.dart' as globals;

class CheckAddAcctOtherScreen extends StatefulWidget {
  String bankName;
  String acctNumber;
  CheckAddAcctOtherScreen({this.acctNumber, this.bankName});
  @override
  _CheckAddAcctOtherScreenState createState() =>
      _CheckAddAcctOtherScreenState(bankName: bankName, acctNumber: acctNumber);
}

String addBankName = "";
String addAcct_No = "";
String addAcct_Name = "";

class _CheckAddAcctOtherScreenState extends State<CheckAddAcctOtherScreen> {
  XSignature randReqRefNo = XSignature();
  CheckAddAcctOtherConnection checkAddOtherConnect =
      CheckAddAcctOtherConnection(globals.iPV4, '8080');
  AddOtherUserAcctConnection addOtherUserAcctConnect =
      AddOtherUserAcctConnection(globals.iPV4, '8080');
  String bankName;
  String acctNumber;

  _CheckAddAcctOtherScreenState({this.bankName, this.acctNumber});

  String cutNameBank(String bankName) {
    String output = "";
    int lengthBankName = bankName.length;
    for (int i = 6; i < lengthBankName; i++) {
      output += bankName[i];
    }
    return output;
  }

  Future<void> addOtherUserAcct() async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoAddAcctOther: ' + reqRefNo);
    AddOtherUserAcctRequest request = AddOtherUserAcctRequest(
        acct_Name: addAcct_Name,
        acct_No: addAcct_No,
        bank_Name: addBankName,
        reqRefNo: reqRefNo);
    await addOtherUserAcctConnect
        .connectAddOtherUserAcct(request, globals.token)
        .then((value) {
      //print('status code AddAcctOther= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        AddOtherUserAcctResponse response =
            AddOtherUserAcctResponse.fromJson(responseMap);
        print("respDescCodeAddAcctOther: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          print('add other account success');
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "เพิ่มบัญชีบุคคลอื่นสำเร็จ",
              textStyle: TextStyle(fontSize: 20),
            ),
          );
          Navigator.of(context)
              .popUntil(ModalRoute.withName(PageTo.indexScreen));
        }
      }
    });
  }

  Future<CheckAddAcctOtherModel> checkAddAcctOther() async {
    CheckAddAcctOtherModel res = new CheckAddAcctOtherModel();
    String bankNameCut = cutNameBank(bankName);
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoCheckAddAcctOther: ' + reqRefNo);
    CheckAddAcctOtherRequest request = CheckAddAcctOtherRequest(
        acctNo: acctNumber, reqRefNo: reqRefNo);
    await checkAddOtherConnect
        .connectCheckAddAcctOther(request, globals.token)
        .then((value) {
      //print('status code CheckAddAcctOther= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        CheckAddAcctOtherResponse response =
            CheckAddAcctOtherResponse.fromJson(responseMap);
        print("respDescCodeCheckAddAcctOther: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          res.acct_Name = response.nameTh!=null?response.nameTh:response.nameEn;
          res.acct_No = response.acctNo;
          res.bankName = "ไทยพาณิชย์";//vas ไม่มีธนาคาร
        } else {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: "โปรดตรวจบัญชีใหม่อีกครั้ง",
              textStyle: TextStyle(fontSize: 20, color: Colors.white),
            ),
          );
          Navigator.pop(context);
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
        resizeToAvoidBottomInset: false,
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
                      addOtherUserAcct();
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
    return FutureBuilder<CheckAddAcctOtherModel>(
      future: checkAddAcctOther(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var data = snapshot.data;
          addAcct_Name = data.acct_Name;
          addAcct_No = data.acct_No;
          addBankName = data.bankName;
          return Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Container(
              padding:
                  EdgeInsets.only(left: _height * 0.01, right: _height * 0.01),
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
                      backgroundImage:
                          AssetImage('assests/images/avatar-circle.png'),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'ธนาคาร',
                        style: TextStyle(fontSize: _height * 0.024),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          //width: _width*0.4,
                          padding: EdgeInsets.only(
                              left: _height * 0.02, right: _height * 0.02),
                          color: Colors.grey[300],
                          child: Text(
                            data.bankName,
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
                        'หมายเลขบัญชี',
                        style: TextStyle(fontSize: _height * 0.024),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          //width: _width*0.4,
                          padding: EdgeInsets.only(
                              left: _height * 0.02, right: _height * 0.02),
                          color: Colors.grey[300],
                          child: Text(
                            data.acct_No,
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
                            data.acct_Name,
                            style: TextStyle(fontSize: _height * 0.024),
                          ))
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

  Widget _buildBackgroundImageBlur(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      color: Color(0xFFF4F0F9),
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //         image: ExactAssetImage('assests/images/pink-geometric.jpg'),
      //         fit: BoxFit.cover)),
      // child: BackdropFilter(
      //   filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      //   child: Container(
      //     decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
        // ),
      // ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return AppBar(
        backgroundColor: Color(0xFF3b074b),
        centerTitle: true,
        title: Text(
          'ตรวจสอบบัญชี',
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }
}
