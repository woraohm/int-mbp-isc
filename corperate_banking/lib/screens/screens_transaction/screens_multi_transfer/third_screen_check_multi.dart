import 'dart:ffi';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/select_account_to_add_group_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/create_order_multi_transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:rest_package/model/inquily_info_transfer_group_model_response.dart';

class CheckMultiTransferScreen extends StatefulWidget {
  String groupName;
  String fromAcctNo;
  String fromBankName;
  String fromAcctName;
  List<InquilyInfoTransferGroupModelResponse> listResponse = [];

  CheckMultiTransferScreen(
      {this.groupName,
      this.fromBankName,
      this.fromAcctNo,
      this.fromAcctName,
      this.listResponse});
  @override
  _CheckMultiTransferScreenState createState() =>
      _CheckMultiTransferScreenState(
          groupName: groupName,
          fromBankName: fromBankName,
          fromAcctNo: fromAcctNo,
          fromAcctName: fromAcctName,
          listResponse: listResponse);
}

class _CheckMultiTransferScreenState extends State<CheckMultiTransferScreen> {
  String groupName;
  String fromAcctNo;
  String fromBankName;
  String fromAcctName;
  List<InquilyInfoTransferGroupModelResponse> listResponse = [];
  _CheckMultiTransferScreenState(
      {this.groupName,
      this.fromAcctNo,
      this.fromBankName,
      this.fromAcctName,
      this.listResponse});
  FunctionGlobal func = FunctionGlobal();
  double sumAmonth = 0;

  

  @override
  void initState() {
    print("AAAAAAAAAAAAlengthListResponse: "+listResponse.length.toString());
    this.sumAmonth = 0;
    setState(() {
      for (var data in this.listResponse) {
        this.sumAmonth += data.transAmount;
      }
    });
    
    super.initState();
  }
 

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('ตรวจสอบข้อมูล',style: TextStyle(fontSize: _height*0.03,),),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,color: Colors.white),
              onPressed: (){

                this.listResponse.clear();
                print("lengthListResponse: "+listResponse.length.toString());
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: backgroundColor,
          body: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: _height * 0.01, bottom: _height * 0.01),
                color: Colors.white,
                alignment: Alignment.center,
                child: Text(
                  groupName,
                  style: TextStyle(fontSize: _height * 0.028),
                ),
              ),
              Container(
                width: _width,
                height: _height * 0.001,
                color: Colors.grey[300],
              ),
              _buildFormData(context),
              Padding(
                padding: EdgeInsets.only(
                    left: _height * 0.02,
                    right: _height * 0.02,
                    top: _height * 0.02),
                child: Text(
                  'ผู้รับเงิน',
                  style:
                      TextStyle(fontSize: _height * 0.026, color: Colors.grey),
                ),
              ),
              _buildRecipientData(context),
              Padding(
                padding: EdgeInsets.only(
                    left: _height * 0.02,
                    right: _height * 0.02,
                    top: _height * 0.02),
                child: Text(
                  'ยอดโอนเงินทั้งหมด',
                  style:
                      TextStyle(fontSize: _height * 0.026, color: Colors.grey),
                ),
              ),
              _buildTotalAmount(context),
              SizedBox(
                height: _height * 0.02,
              ),
              _buildButtonConfirm(context)
            ],
          )),
    );
  }

  Widget _buildFormData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
          left: _height * 0.02, right: _height * 0.02, top: _height * 0.02),
      //alignment: Alignment.center,
      width: _width,
      height: _height * 0.12,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'จาก',
            style: TextStyle(fontSize: _height * 0.028),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: func.checkLogoBank(this.fromBankName),
                  ),
                  SizedBox(
                    width: _height * 0.01,
                  ),
                  Text(
                    this.fromAcctName,
                    style: TextStyle(fontSize: _height * 0.026),
                  ),
                ],
              ),
              Text(
                this.fromAcctNo,
                style: TextStyle(fontSize: _height * 0.026, color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRecipientData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        for (var data in this.listResponse)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                    left: _height * 0.02,
                    right: _height * 0.02,
                    top: _height * 0.02),
                width: _width,
                height: _height * 0.12,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'ไปยัง',
                      style: TextStyle(fontSize: _height * 0.028),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  func.checkLogoBank(data.bank_Name_Recipient),
                            ),
                            SizedBox(
                              width: _height * 0.01,
                            ),
                            Text(
                              data.recipient_account_No_name_Th != null
                                  ? data.recipient_account_No_name_Th
                                  : data.recipient_account_No_name_En,
                              style: TextStyle(fontSize: _height * 0.026),
                            ),
                          ],
                        ),
                        Text(
                          data.recipient_account_No,
                          style: TextStyle(
                              fontSize: _height * 0.026, color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.001,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  left: _height * 0.02,
                  right: _height * 0.02,
                ),
                width: _width,
                height: _height * 0.08,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'จำนวนเงิน',
                      style: TextStyle(fontSize: _height * 0.026),
                    ),
                    Text(
                      '${formatMoney.format(data.transAmount)}',
                      style: TextStyle(fontSize: _height * 0.026),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.001,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  left: _height * 0.02,
                  right: _height * 0.02,
                ),
                width: _width,
                height: _height * 0.08,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'ค่าธรรมเนียม',
                      style: TextStyle(fontSize: _height * 0.026),
                    ),
                    Text(
                      '${formatMoney.format(data.fee)}',
                      style: TextStyle(fontSize: _height * 0.026),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
            ],
          ),
      ],
    
    );
    
  }

  Widget _buildTotalAmount(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(
        left: _height * 0.02,
        right: _height * 0.02,
      ),
      width: _width,
      height: _height * 0.24,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'จำนวนเงินทั้งหมด',
                style: TextStyle(fontSize: _height * 0.026),
              ),
              Text(
                '${formatMoney.format(sumAmonth)}',
                style: TextStyle(fontSize: _height * 0.026),
              ),
            ],
          )),
          Divider(),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'ค่าธรรมเนียมทั้งหมด',
                style: TextStyle(fontSize: _height * 0.026),
              ),
              Text(
                '0.00',
                style: TextStyle(fontSize: _height * 0.026),
              ),
            ],
          )),
          Divider(),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'ยอดรวมทั้งหมดทั้งหมด',
                style: TextStyle(fontSize: _height * 0.026),
              ),
              Text(
                '300.00',
                style: TextStyle(fontSize: _height * 0.026),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildButtonConfirm(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: _height * 0.02,
        right: _height * 0.02,
      ),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateOrderMultiTrasnferScreen(
                      fromAcctNo: fromAcctNo,
                      fromAcctName: fromAcctName,
                      fromBankName: fromBankName,
                      groupName: groupName,
                    ))),
        child: Card(
          elevation: 5,
          color: backgroundMainColor,
          child: Container(
            alignment: Alignment.center,
            width: _width,
            height: _height * 0.07,
            child: Text(
              'ยืนยัน',
              style: TextStyle(fontSize: _height * 0.03, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
