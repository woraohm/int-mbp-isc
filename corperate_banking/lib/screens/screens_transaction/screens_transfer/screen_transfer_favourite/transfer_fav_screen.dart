import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';

class TransferSingleFavScreen extends StatefulWidget {
  @override
  _TransferFavScreenState createState() => _TransferFavScreenState();
}

class _TransferFavScreenState extends State<TransferSingleFavScreen> {
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
          child: Scaffold(
          backgroundColor: Color(0xFFCFCFCF),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            backgroundColor: Colors.red,
            centerTitle: true,
            title: Text(
              'โอนเงิน',
              style: TextStyle(fontSize: _height * 0.03),
            ),
          ),
          body: Container(
            height: _height,
            width: _width,
            padding: EdgeInsets.only(
                left: _height * 0.02, right: _height * 0.02, top: _height * 0.01),
            child: ListView(
              children: <Widget>[
                Text(
                  'จาก',
                  style: TextStyle(
                      fontSize: _height * 0.023, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                InkWell(
                  child: Card(
                    elevation: 5,
                    child: Container(
                      height: _height * 0.1,
                      width: _width,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: _height,
                            width: _width * 0.04,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: _height,
                            width: _width * 0.2,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assests/images/logo_isc_medium_orange.png'),
                              backgroundColor: Colors.yellow,
                              radius: _height * 0.03,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: _height,
                            width: _width * 0.25,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: _height * 0.02,
                                ),
                                Container(
                                  child: Text(
                                    'ออมทรัพย์',
                                    style: TextStyle(fontSize: _height * 0.024),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '999-9-9999-9',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: _height * 0.015),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: _height,
                            width: _width * 0.32,
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  height: _height * 0.02,
                                ),
                                Container(
                                  child: Text(
                                    '9,999,999,999',
                                    style: TextStyle(fontSize: _height * 0.024),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    ' บาท',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: _height * 0.015),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: _height * 0.05,
                ),
                SizedBox(
                  height: _height * 0.03,
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'ถึง',
                      style: TextStyle(
                          fontSize: _height * 0.023,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                Card(
                  child: Container(
                    height: _height * 0.65,
                    width: _width,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: _height,
                                  width: _width * 0.05,
                                ),
                                Container(
                                  height: _height,
                                  width: _width * 0.2,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assests/images/SCB-logo.png'),
                                    backgroundColor: Colors.yellow,
                                  ),
                                ),
                                Container(
                                  width: _width * 0.04,
                                  height: _height,
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: _height * 0.02,
                                      ),
                                      Container(
                                        child: Text(
                                          'โอนเงินรายการโปรด',
                                          style: TextStyle(
                                              fontSize: _height * 0.025),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'ธนาคารไทยพาณิชย์',
                                          style: TextStyle(
                                              fontSize: _height * 0.025),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: _height * 0.02),
                                  child: Text(
                                    'หมายเลขบัญชี',
                                    style: TextStyle(fontSize: _height * 0.025),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  padding: EdgeInsets.only(
                                      top: _height * 0.02, right: _height * 0.02),
                                  child: Text(
                                    '777-7-7777-7',
                                    style: TextStyle(fontSize: _height * 0.025),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Expanded(
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: _height * 0.02),
                                  child: Text(
                                    'จำนวนเงิน',
                                    style: TextStyle(fontSize: _height * 0.025),
                                  ),
                                ),
                                Container(
                                  height: _height,
                                  width: _width * 0.12,
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  height: _height,
                                  width: _width * 0.45,
                                  child: TextFormField(
                                    decoration:
                                        InputDecoration(hintText: 'จำนวนเงิน'),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: Text(' บาท'),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Expanded(
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: _height * 0.02),
                                  child: Text(
                                    'บันทึก',
                                    style: TextStyle(fontSize: _height * 0.025),
                                  ),
                                ),
                                Container(
                                  height: _height,
                                  width: _width * 0.18,
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  height: _height,
                                  width: _width * 0.45,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'กรุณาใส่เหตุผล'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: _height,
                            width: _width,
                            padding: EdgeInsets.all(_height * 0.02),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageTo.checkTransferScreen);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'ตรวจสอบข้อมูล',
                                  style: TextStyle(
                                      fontSize: _height * 0.023,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
