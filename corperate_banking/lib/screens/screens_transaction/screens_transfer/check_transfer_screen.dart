import 'dart:convert';


import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_transfer/create_order_transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:rest_package/bean/transf_single_created_order_success_request.dart';
import 'package:rest_package/bean/transf_single_created_order_success_response.dart';
import 'package:rest_package/connection/transf_single_created_order_success_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;

class CheckTransferScreen extends StatefulWidget {
  String fromAcctName;
  String transfType;
  String fromBankName;
  String fromAcctType;
  String fromAcctNumber;
  String toBankName;
  String toAcctName;
  double fee;
  String toAcctNumber;
  double toAmount;
  String toNote;

  CheckTransferScreen({
    this.fromAcctName,
    this.transfType,
    this.toAcctNumber,
    this.toBankName,
    this.toAmount,
    this.toNote,
    this.fee,
    this.toAcctName,
    this.fromAcctType,
    this.fromAcctNumber,
    this.fromBankName,
  });

  @override
  _CheckTransferScreenState createState() => _CheckTransferScreenState(
      fromAcctName: fromAcctName,
      transfType: transfType,
      fromAcctType: fromAcctType,
      fromAcctNumber: fromAcctNumber,
      fromBankName: fromBankName,
      toAcctNumber: toAcctNumber,
      toAmount: toAmount,
      toBankName: toBankName,
      toAcctName: toAcctName,
      fee: fee,
      toNote: toNote);
}

class _CheckTransferScreenState extends State<CheckTransferScreen> {
  String fromAcctName;
  String transfType;
  String fromBankName;
  String fromAcctType;
  String fromAcctNumber;
  String toBankName;
  String toAcctName;
  String toAcctNumber;
  double toAmount;
  String toNote;
  double fee;
  _CheckTransferScreenState({
    this.fromAcctName,
    this.transfType,
    this.toAcctNumber,
    this.toBankName,
    this.toAmount,
    this.toNote,
    this.fee,
    this.toAcctName,
    this.fromAcctType,
    this.fromAcctNumber,
    this.fromBankName,
  });
  XSignature randReqRefNo = XSignature();
  TransfSingleCreatedOrderSuccessConnection
      transfSingleCreateOrderSuccessConnect =
      TransfSingleCreatedOrderSuccessConnection(globals.iPV4, '8080');

  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  String toAcctType;
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
        return ;
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
        return "ธนาคารธนชาติ";
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

  Future<void> transfNow() async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoTransfSingleCreateOrderSuccess: ' + reqRefNo);
    TransfSingleCreatedOrderSuccessRequest request =
        TransfSingleCreatedOrderSuccessRequest(
            sender_Account_No_name_Th: fromAcctName,
            sender_lk_acct_type_name: fromAcctType,
            bank_Name_Recipient: toBankName,
            bank_Name_Sender: fromBankName,
            fee: 0,
            note: toNote,
            trnfType: transfType,
            recipient_account_No: toAcctNumber,
            recipient_account_No_name_En: "",
            recipient_account_No_name_Th: toAcctName,
            sender_Account_No: fromAcctNumber,
            transAmount: toAmount,
            reqRefNo: reqRefNo);
    await transfSingleCreateOrderSuccessConnect
        .transfSingleCreatedOrderSuccessConnection(request, globals.token)
        .then((value) {
      // print('status code transfSingleCreateOrderSuccess= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfSingleCreatedOrderSuccessResponse response =
            TransfSingleCreatedOrderSuccessResponse.fromJson(responseMap);
        //print("respDescTransfSingleCreateOrderSuccess: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
              print(response.bank_Name_Sender);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateOrderTransferScreen(
                        fromAcctNumber: response.sender_Account_No,
                        fromAcctType: response.sender_lk_acct_type_name,
                        fromBankName: response.bank_Name_Sender,
                        toAcctNumber: response.recipient_account_No,
                        toBankName: response.bank_Name_Recipient,
                        toAcctName: response.recipient_account_No_name_Th,
                    
                        toAmount: response.amount,
                        toNote: response.note,
                        dateTime: response.dateTime,
                        tracNo: response.traceNo,
                        fee: response.fee,
                        
                      )));
        }else{
          print("กรุณาทำรายการใหม่อีกครั้ง");
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
        backgroundColor: Color(0xFFeaecf0),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Color(0xFF3b074b),
          centerTitle: true,
          title: Text(
            'ตรวจสอบข้อมูล',
            style: TextStyle(fontSize: _height * 0.03),
          ),
        ),
        body: Container(
          width: _width,
          height: _height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: _height * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(left: _height * 0.02),
                child: Text(
                  'รายละเอียดการโอนเงิน',
                  style: TextStyle(
                      fontSize: _height * 0.026, fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: _height * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: _height * 0.02, right: _height * 0.02),
                height: _height * 0.3,
                width: _width,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'จาก',
                        style: TextStyle(
                            fontSize: _height * 0.023,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      height: _height * 0.1,
                      width: _width,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: _height,
                            width: _width * 0.02,
                            color: Color(0xFF3b074b),
                          ),
                          Container(
                            padding: EdgeInsets.all(_height * 0.02),
                            height: _height,
                            width: _width * 0.2,
                            child: CircleAvatar(
                              backgroundImage: 
                              fromBankName=='ไม่มีธนาคาร'?
                              AssetImage('assests/images/avatar-circle.png'):
                              checkLogoBank(fromBankName),
                              
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: _height * 0.02,
                              ),
                              Container(
                                child: Text(
                                  fromAcctType,
                                  style: TextStyle(fontSize: _height * 0.02),
                                ),
                              ),
                              Container(
                                child: Text(
                                  fromAcctNumber,
                                  style: TextStyle(
                                      fontSize: _height * 0.02,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'ถึง',
                        style: TextStyle(
                            fontSize: _height * 0.023,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      height: _height * 0.1,
                      width: _width,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: _height,
                            width: _width * 0.02,
                            color: Color(0xFF3b074b),
                          ),
                          Container(
                            padding: EdgeInsets.all(_height * 0.02),
                            height: _height,
                            width: _width * 0.2,
                            child: CircleAvatar(
                              backgroundImage: toBankName==null?
                              AssetImage('assests/images/avatar-circle.png'):
                              checkLogoBank(toBankName),
                              
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: _height * 0.01,
                              ),
                              Container(
                                child: Text(
                                  toAcctName ,
                                  style: TextStyle(fontSize: _height * 0.02),
                                ),
                              ),
                              // Container(
                              //   child: Text(
                              //     checkNameBankFromLogo(toBankName),
                              //     style: TextStyle(
                              //         fontSize: _height * 0.018,
                              //         color: Colors.grey),
                              //   ),
                              // ),
                              Container(
                                child: Text(
                                  toAcctNumber,
                                  style: TextStyle(
                                      fontSize: _height * 0.018,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(left: _height * 0.02),
                child: Text(
                  'ยอดโอนเงิน',
                  style: TextStyle(
                      fontSize: _height * 0.026, fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: _height * 0.01,
              ),
              Container(
                height: _height * 0.08,
                width: _width,
                color: Colors.white,
                padding: EdgeInsets.only(
                    left: _height * 0.02, right: _height * 0.02),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: _width * 0.2,
                      height: _height,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'จำนวนเงิน :',
                        style: TextStyle(
                            fontSize: _height * 0.02, color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: _height,
                      width: _width * 0.6,
                      child: Text(
                        '${formatMoney.format(toAmount)}',
                        style: TextStyle(
                          fontSize: _height * 0.03,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        ' บาท',
                        style: TextStyle(
                            fontSize: _height * 0.02, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.002,
              ),
              Container(
                height: _height * 0.08,
                width: _width,
                color: Colors.white,
                padding: EdgeInsets.only(
                    left: _height * 0.02, right: _height * 0.02),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: _width * 0.2,
                      height: _height,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ค่าธรรมเนียม :',
                        style: TextStyle(
                            fontSize: _height * 0.02, color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: _height,
                      width: _width * 0.6,
                      child: Text(
                        '0.00',
                        style: TextStyle(
                          fontSize: _height * 0.03,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        ' บาท',
                        style: TextStyle(
                            fontSize: _height * 0.02, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Container(
                color: Colors.white,
                width: _width,
                height: _height * 0.1,
                padding: EdgeInsets.only(
                    left: _height * 0.02, right: _height * 0.02),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: _width * 0.2,
                      height: _height,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'บันทึก :',
                        style: TextStyle(
                            fontSize: _height * 0.02, color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: _height,
                      width: _width * 0.7,
                      child: Text(
                        toNote,
                        style: TextStyle(
                            fontSize: _height * 0.023,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.04,
              ),
              Container(
                  width: _width,
                  height: _height * 0.08,
                  padding: EdgeInsets.only(
                      left: _height * 0.02,
                      right: _height * 0.02,
                      bottom: _height * 0.01),
                  child: _buildButtonCheckSucess(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonCheckSucess(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        transfNow();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFF3b074b),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          'ยืนยัน',
          style: TextStyle(fontSize: _height * 0.025, color: Colors.white),
        ),
      ),
    );
  }
}
