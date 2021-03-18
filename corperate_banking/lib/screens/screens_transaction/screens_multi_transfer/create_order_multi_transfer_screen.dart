import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/select_account_to_add_group_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateOrderMultiTrasnferScreen extends StatefulWidget {
  String fromBankName;
  String fromAcctNo;
  String groupName;
  String fromAcctName;

  CreateOrderMultiTrasnferScreen(
      {this.groupName, this.fromAcctNo, this.fromBankName, this.fromAcctName});

  @override
  _CreateOrderMultiTrasnferScreenState createState() =>
      _CreateOrderMultiTrasnferScreenState(
          fromAcctNo: fromAcctNo,
          fromBankName: fromBankName,
          groupName: groupName,
          fromAcctName: fromAcctName);
}

class _CreateOrderMultiTrasnferScreenState
    extends State<CreateOrderMultiTrasnferScreen> {
  String fromBankName;
  String fromAcctNo;
  String groupName;
  String fromAcctName;
  _CreateOrderMultiTrasnferScreenState(
      {this.groupName, this.fromAcctNo, this.fromBankName, this.fromAcctName});
  FunctionGlobal func = FunctionGlobal();
  List<AccountUser> res = [
    AccountUser(
        acctName: 'ตัวอย่าง ตัวอย่าง',
        acctNo: '123-123123-1',
        bankName: 'ไทยพาณิชย์',
        amount: 100,
        ischeck: false),
    AccountUser(
        acctName: 'ตัวอย่าง ตัวอย่าง',
        acctNo: '123-123123-2',
        bankName: 'ไทยพาณิชย์',
        amount: 100,
        ischeck: false),
    AccountUser(
        acctName: 'ตัวอย่าง ตัวอย่าง',
        acctNo: '123-123123-3',
        bankName: 'ไทยพาณิชย์',
        amount: 100,
        ischeck: false),
  ];
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => func.onBackPressed(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundMainColor,
          body: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: _height * 0.02,
                    right: _height * 0.02,
                    top: _height * 0.02),
                child: Container(
                  width: _width,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: _height * 0.02),
                          alignment: Alignment.topCenter,
                          width: _width,
                          height: _height * 0.1,
                          child: Text(
                            groupName,
                            style: TextStyle(fontSize: _height * 0.026),
                          )),
                      Container(
                        width: _width,
                        height: _height * 0.001,
                        color: Colors.grey[200],
                      ),
                      _buildFormData(context),
                      Container(
                        width: _width,
                        height: _height * 0.001,
                        color: Colors.grey[200],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: _height * 0.02,
                              right: _height * 0.02,
                              top: _height * 0.02,
                              bottom: _height * 0.02),
                          child: Text(
                            'โอนเงินสำเร็จ',
                            style: TextStyle(
                                fontSize: _height * 0.026, color: Colors.green),
                          ),
                        ),
                      ),
                      Container(
                        width: _width,
                        height: _height * 0.001,
                        color: Colors.grey[200],
                      ),
                      _buildData(context),
                      Container(
                        width: _width,
                        height: _height * 0.001,
                        color: Colors.grey[200],
                      ),
                      _buildToGroupData(context),
                      Container(
                        width: _width,
                        height: _height * 0.001,
                        color: Colors.grey[200],
                      ),
                      _buildQRCode(context),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              _buildButtonSuccess(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
          left: _height * 0.02, right: _height * 0.02, top: _height * 0.01),
      width: _width,
      height: _height * 0.12,
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
                    backgroundImage: func.checkLogoBank(fromBankName),
                  ),
                  SizedBox(
                    width: _height * 0.01,
                  ),
                  Text(
                    'ตัวอย่าง ตัวอย่าง',
                    style: TextStyle(fontSize: _height * 0.026),
                  ),
                ],
              ),
              Text(
                '666-777888-9',
                style: TextStyle(fontSize: _height * 0.026, color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
          left: _height * 0.02, right: _height * 0.02, top: _height * 0.01),
      width: _width,
      child: Column(
        children: <Widget>[
          Container(
            width: _width,
            height: _height * 0.06,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'เลขที่รายการ',
                  style: TextStyle(fontSize: _height * 0.026),
                ),
                Text(
                  '1234567890',
                  style:
                      TextStyle(fontSize: _height * 0.026, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            width: _width,
            height: _height * 0.001,
            color: Colors.grey[200],
          ),
          Container(
            width: _width,
            height: _height * 0.06,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'จำนวนเงินทั้งหมด',
                  style: TextStyle(fontSize: _height * 0.026),
                ),
                Text(
                  '300.00',
                  style:
                      TextStyle(fontSize: _height * 0.026, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            width: _width,
            height: _height * 0.001,
            color: Colors.grey[200],
          ),
          Container(
            width: _width,
            height: _height * 0.06,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'ค่าธรรมเนียมทั้งหมด',
                  style: TextStyle(fontSize: _height * 0.026),
                ),
                Text(
                  '300.00',
                  style:
                      TextStyle(fontSize: _height * 0.026, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            width: _width,
            height: _height * 0.001,
            color: Colors.grey[200],
          ),
          Container(
            width: _width,
            height: _height * 0.06,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'ยอดรวมทั้งหมด',
                  style: TextStyle(fontSize: _height * 0.026),
                ),
                Text(
                  '300.00',
                  style:
                      TextStyle(fontSize: _height * 0.026, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToGroupData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        for (var data in res)
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: _height * 0.02,
                    right: _height * 0.02,
                    top: _height * 0.01),
                child: Container(
                    width: _width,
                    height: _height * 0.15,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      func.checkLogoBank(data.bankName),
                                ),
                                SizedBox(
                                  width: _height * 0.01,
                                ),
                                Text(
                                  data.acctName,
                                  style: TextStyle(fontSize: _height * 0.026),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                ),
                                SizedBox(
                                  width: _height * 0.01,
                                ),
                                Text(
                                  data.acctNo,
                                  style: TextStyle(
                                      fontSize: _height * 0.024,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            Text(
                              '100.00',
                              style: TextStyle(fontSize: _height * 0.026),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(
                                  fontSize: _height * 0.024,
                                  color: Colors.grey),
                            ),
                            Text(
                              '0.00',
                              style: TextStyle(fontSize: _height * 0.026),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
              Container(
                width: _width,
                height: _height * 0.001,
                color: Colors.grey[200],
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildButtonSuccess(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          left: _height * 0.02, right: _height * 0.02, top: _height * 0.01),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .popUntil(ModalRoute.withName(PageTo.indexScreen));
        },
        child: Card(
          elevation: 5,
          color: Colors.red,
          child: Container(
            alignment: Alignment.center,
            width: _width,
            height: _height * 0.07,
            child: Text(
              'เสร็จสิ้น',
              style: TextStyle(fontSize: _height * 0.03, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQRCode(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
        left: _height * 0.02,
        right: _height * 0.02,
      ),
      width: _width,
      height: _height * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'ท่านสามารถสแกนคิวอาร์โค้ดนี้\nเพื่อตรวจสอบสถานะการโอนเงิน',
            style: TextStyle(fontSize: _height * 0.023),
          ),
          QrImage(data: '1234567890')
        ],
      ),
    );
  }
}
