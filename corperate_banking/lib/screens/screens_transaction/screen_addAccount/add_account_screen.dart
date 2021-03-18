import 'dart:convert';

import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screens_transaction/screen_addAccount/check_acct_other_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screen_addAccount/check_add_promptpay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:http/http.dart';
import 'package:rest_package/bean/check_add_promptpay_other_request.dart';
import 'package:rest_package/bean/check_add_promptpay_other_response.dart';
import 'package:rest_package/connection/check_add_promptpay_other_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;

class AddAccountScreen extends StatefulWidget {
  @override
  _AddAccountScreenState createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  final tabController = PageController();
  String promptpayNumber="";
  String promptpayName="";
  var acctNumberController =
      MaskedTextController(text: '', mask: '000-000000-0');
  TextEditingController promptpayNumberController = TextEditingController();
  XSignature randReqRefNo = XSignature();
  CheckAddPromptpayOtherConnection checkAddPromptpayOtherconnect =
      CheckAddPromptpayOtherConnection(globals.iPV4, '8080');

  Future<void> checkAddPromptpay(String promptpayNumber) async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoCheckAddPromptpay: ' + reqRefNo);
    CheckAddPromptpayOtherRequest request = CheckAddPromptpayOtherRequest(
        reqRefNo: reqRefNo, prompt_Pay_No: promptpayNumber);
    await checkAddPromptpayOtherconnect
        .connectCheckAddPromptpayOther(request, globals.token)
        .then((value) {
      //print('status code CheckAddPromptpay= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        CheckAddPromptpayOtherResponse response =
            CheckAddPromptpayOtherResponse.fromJson(responseMap);
        print("respDescCodeCheckAddPromptpay: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CheckAddPromptpayScreen(
                        promptpayNumber: response.prompt_Pay_No,
                        promptpayName: response.acctName
                      )));
        }else{
          print('check promptpay error!!');
        }
        }else{
          print('connect check promptpay error!!');
        }
    });
  }

  String bankName = 'ธนาคารไทยพาณิชย์';
  checkLogoBank(String bankName) {
    switch (bankName) {
      case "ธนาคารไทยพาณิชย์":
        return AssetImage('assests/images/SCB-logo.png');
        break;
      case "ธนาคารกรุงเทพ":
        return AssetImage('assests/images/BBL-logo.png');
        break;
      case "ธนาคารกรุงไทย":
        return AssetImage('assests/images/KTB-logo.png');
        break;
      case "ธนาคารกรุงศรีอยุธยา":
        return AssetImage('assests/images/BAY.png');
        break;
      case "ธนาคารกสิกรไทย":
        return AssetImage('assests/images/KBANK-logo.png');
        break;
      case "ธนาคารทหารไทย":
        return AssetImage('assests/images/TMB-logo.png');
        break;
      case "ธนาคารธนชาติ":
        return AssetImage('assests/images/NBANK-logo.png');
        break;
      case "ธนาคารอาคารสงเคราะห์":
        return AssetImage('assests/images/GHB-logo.jpg');
        break;
      case "ธนาคารอมมสิน":
        return AssetImage('assests/images/GSB-logo.jpg');
        break;

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFFeaecf0),
          appBar: _buildAppbar(context, _height),
          body: TabBarView(
            children: <Widget>[
              _buildOtherAccount(context),
              _buildOtherPromptpay(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppbar(BuildContext context, double _height) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      backgroundColor: Color(0xFF3b074b),
      centerTitle: true,
      title: Text(
        'เพิ่มบัญชี',
        style:
            TextStyle(fontSize: _height * 0.023, fontWeight: FontWeight.w500),
      ),
      bottom: TabBar(
        indicatorColor: Colors.white,
        tabs: <Tab>[
          Tab(
            child: Text(
              'เพิ่มบัญชีบุคคลอื่น',
              style: TextStyle(fontSize: _height * 0.023),
            ),
          ),
          Tab(
            child: Text(
              'เพิ่มบัญชีพร้อมเพย์',
              style: TextStyle(fontSize: _height * 0.023),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOtherAccount(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFeaecf0), Colors.white])),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: _height * 0.05,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'กรุณากรอกข้อมูล',
                  style: TextStyle(
                      fontSize: _height * 0.023, fontWeight: FontWeight.w500),
                )),
          ),
          Stack(
            children: <Widget>[
              Container(
                height: _height * 0.1,
                width: _width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(40)),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: _height * 0.035,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: _height * 0.02,
                        right: _height * 0.02,
                        top: _height * 0.02),
                    height: _height * 0.68,
                    width: _width,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'เลือกธนาคาร',
                              style: TextStyle(fontSize: _height * 0.023),
                            ),
                            DropdownButton(
                              style: TextStyle(
                                  fontSize: _height * 0.023,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontFamily: 'ThaiSansNeue'),
                              value: bankName,
                              items: <String>[
                                'ธนาคารไทยพาณิชย์',
                                'ธนาคารกรุงเทพ',
                                'ธนาคารกรุงไทย',
                                'ธนาคารกรุงศรีอยุธยา',
                                'ธนาคารกสิกรไทย',
                                'ธนาคารทหารไทย',
                                'ธนาคารธนชาติ',
                                'ธนาคารออมสิน',
                                'ธนาคารอาคารสงเคราะห์'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String newValue) {
                                setState(() {
                                  bankName = newValue;
                                  print('ธนาคารที่เลือก: ' + bankName);
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'หมายเลขบัญชี',
                                style: TextStyle(fontSize: _height * 0.023),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(fontSize: _height * 0.023),
                                controller: acctNumberController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: 'ใส่หมายเลขบัญชี'),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(
                          height: _height * 0.02,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: _width * 0.5,
                            height: _height * 0.05,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(),
                                ),
                                SizedBox(
                                  width: _height * 0.01,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CheckAddAcctOtherScreen(
                                                    acctNumber:
                                                        acctNumberController
                                                            .text,
                                                    bankName: bankName,
                                                  )));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF3b074b),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        'ตรวจสอบข้อมูล',
                                        style: TextStyle(
                                            fontSize: _height * 0.018,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOtherPromptpay(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFeaecf0), Colors.white])),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: _height * 0.05,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'กรุณากรอกข้อมูล',
                  style: TextStyle(
                      fontSize: _height * 0.023, fontWeight: FontWeight.w500),
                )),
          ),
          Stack(
            children: <Widget>[
              Container(
                height: _height * 0.1,
                width: _width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(40)),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: _height * 0.035,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: _height * 0.02,
                        right: _height * 0.02,
                        top: _height * 0.02),
                    height: _height * 0.68,
                    width: _width,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                                child: Text(
                              'หมายเลขพร้อมเพย์',
                              style: TextStyle(fontSize: _height * 0.023),
                            )),
                            Expanded(
                              child: Container(
                                width: _width,
                                height: _height * 0.05,
                                child: TextFormField(
                                  controller: promptpayNumberController,
                                  style: TextStyle(fontSize: _height * 0.02),
                                  decoration: InputDecoration(
                                    hintText:
                                        ' หมายเลขบัตรประชาชน / เบอร์โทรศัพท์',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: _height * 0.03,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: _width * 0.5,
                            height: _height * 0.05,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(),
                                ),
                                SizedBox(
                                  width: _height * 0.01,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      checkAddPromptpay(
                                          promptpayNumberController.text);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF3b074b),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        'ตรวจสอบข้อมูล',
                                        style: TextStyle(
                                            fontSize: _height * 0.018,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
