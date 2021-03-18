import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DischeckerScreen extends StatefulWidget {
  @override
  _DischeckerScreenState createState() => _DischeckerScreenState();
}

class _DischeckerScreenState extends State<DischeckerScreen> {
 
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
          child: Scaffold(
        backgroundColor: Color(0xFFCFCFCF),
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text(
            'รายการไม่ผ่านการตรวจสอบ',
            style: TextStyle(fontSize: _height * 0.03),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: _height * 0.01,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(
                            left: _height * 0.02, right: _height * 0.02),
                        width: _width,
                        height: _height * 0.77,
                        child: ClipPath(
                          clipper: PointsClipper(),
                          child: Container(
                            height: _height * 0.1,
                            width: _width,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: _height * 0.05,
                          ),
                          Container(
                            width: _width,
                            height: _height * 0.9,
                            // color: Colors.green,
                            padding: EdgeInsets.only(
                                left: _height * 0.02, right: _height * 0.02),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: _width,
                                  height: _height * 0.66,
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: _height * 0.05,
                                      ),
                                      Container(
                                        width: _width,
                                        color: Colors.white,
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height: _height * 0.01,
                                            ),
                                            Container(
                                              height: _height * 0.045,
                                              width: _width,
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                'รายการการโอน',
                                                style: TextStyle(
                                                    fontSize: _height * 0.04,
                                                    fontWeight: FontWeight.w300),
                                              ),
                                            ),
                                            Container(
                                              height: _height * 0.03,
                                              width: _width,
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                '13 เมษายน 2563 16:30:30',
                                                style: TextStyle(
                                                    fontSize: _height * 0.023,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            SizedBox(
                                              height: _height * 0.01,
                                            ),
                                            Container(
                                              width: _width,
                                              height: _height * 0.17,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left: _height * 0.02,
                                                    ),
                                                    width: _width,
                                                    height: _height * 0.075,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text(
                                                            'จาก',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    _height *
                                                                        0.023),
                                                          ),
                                                          width: _width * 0.1,
                                                          height: _height,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                        ),
                                                        Container(
                                                          width: _width * 0.15,
                                                          height: _height,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: CircleAvatar(
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'assests/images/logo_isc_medium_orange.png'),
                                                            backgroundColor:
                                                                Colors.yellow,
                                                            radius:
                                                                _height * 0.03,
                                                          ),
                                                        ),
                                                        Container(
                                                          width: _width * 0.55,
                                                          height: _height,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              SizedBox(
                                                                height: _height *
                                                                    0.01,
                                                              ),
                                                              Text(
                                                                'ออมทรัพย์',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _height *
                                                                            0.018),
                                                              ),
                                                              Text(
                                                                '999-9-9999-9',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _height *
                                                                            0.015,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: _width,
                                                    height: _height * 0.09,
                                                    padding: EdgeInsets.only(
                                                      left: _height * 0.02,
                                                    ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text(
                                                            'ถึง',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    _height *
                                                                        0.023),
                                                          ),
                                                          width: _width * 0.1,
                                                          height: _height,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                        ),
                                                        Container(
                                                          width: _width * 0.15,
                                                          height: _height,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: CircleAvatar(
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'assests/images/SCB-logo.png'),
                                                            backgroundColor:
                                                                Colors.yellow,
                                                            radius:
                                                                _height * 0.03,
                                                          ),
                                                        ),
                                                        Container(
                                                          width: _width * 0.55,
                                                          height: _height,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              SizedBox(
                                                                height: _height *
                                                                    0.01,
                                                              ),
                                                              Text(
                                                                'คุณ ตัวอย่าง ตัวอย่าง',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _height *
                                                                            0.018),
                                                              ),
                                                              Text(
                                                                'ธนาคารไทยพาณิชย์',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _height *
                                                                            0.015,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              Text(
                                                                '777-7-7777-7',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        _height *
                                                                            0.015,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: _height * 0.02,
                                                right: _height * 0.02,
                                              ),
                                              width: _width,
                                              height: _height * 0.06,
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      'เลขที่รายการ :',
                                                      style: TextStyle(
                                                          fontSize:
                                                              _height * 0.023),
                                                    ),
                                                    width: _width * 0.23,
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    height: _height,
                                                    width: _width * 0.57,
                                                    child: Text(
                                                      '1234567890',
                                                      style: TextStyle(
                                                          fontSize:
                                                              _height * 0.03),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: _height * 0.02,
                                                right: _height * 0.02,
                                              ),
                                              width: _width,
                                              height: _height * 0.06,
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      'จำนวนเงิน :',
                                                      style: TextStyle(
                                                          fontSize:
                                                              _height * 0.023),
                                                    ),
                                                    width: _width * 0.23,
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    height: _height,
                                                    width: _width * 0.5,
                                                    child: Text(
                                                      '7,000.00',
                                                      style: TextStyle(
                                                          fontSize:
                                                              _height * 0.03),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    height: _height,
                                                    width: _width * 0.06,
                                                    child: Text(
                                                      'บาท',
                                                      style: TextStyle(
                                                          fontSize:
                                                              _height * 0.018),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: _height * 0.02,
                                                right: _height * 0.02,
                                              ),
                                              width: _width,
                                              height: _height * 0.06,
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      'ค่าธรรมเนียม :',
                                                      style: TextStyle(
                                                          fontSize:
                                                              _height * 0.023),
                                                    ),
                                                    width: _width * 0.23,
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    height: _height,
                                                    width: _width * 0.5,
                                                    child: Text(
                                                      '0.00',
                                                      style: TextStyle(
                                                          fontSize:
                                                              _height * 0.03),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    height: _height,
                                                    width: _width * 0.06,
                                                    child: Text(
                                                      'บาท',
                                                      style: TextStyle(
                                                          fontSize:
                                                              _height * 0.018),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: _height * 0.02,
                                                right: _height * 0.02,
                                              ),
                                              width: _width,
                                              height: _height * 0.06,
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      'บันทึก :',
                                                      style: TextStyle(
                                                          fontSize:
                                                              _height * 0.023),
                                                    ),
                                                    width: _width * 0.23,
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    height: _height,
                                                    width: _width * 0.57,
                                                    child: Text(
                                                      'ทดสอบการบันทึก ทดสอบการบันทึก ทดสอบการบันทึก ทดสอบการบันทึก',
                                                      style: TextStyle(
                                                          fontSize:
                                                              _height * 0.018),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: _width,
                                              height: _height * 0.1,
                                              color: Colors.white,
                                              padding: EdgeInsets.only(
                                                  left: _height * 0.02,
                                                  top: _height * 0.02),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    height: _height,
                                                    width: _width * 0.3,
                                                    child: Text(
                                                      'สถานะการทำรายการ :',
                                                      style: TextStyle(
                                                          fontSize:
                                                              _height * 0.023),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: _height,
                                                    width: _width * 0.4,
                                                    child: Text(
                                                      'ไม่อนุมัติ กรุณาตรวจสอบจำนวนเงินใหม่อีกครั้ง โดย\nตัวอย่าง ตัวอย่าง',
                                                      style: TextStyle(
                                                          fontSize:
                                                              _height * 0.023,
                                                          color: Colors.red),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            // ClipPath(
                                            //   clipper: PointsClipper(),
                                            //   child: Container(
                                            //     width: _width,
                                            //     height: _height*0.09,
                                            //     color: Colors.white,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  width: _width,
                                  height: _height * 0.085,
                                ),

                                InkWell(
                                  onTap: () {
                                    Alert(
                                      context: context,
                                      type: AlertType.warning,
                                      title: "เลขที่รายการ: 1234567890",
                                      desc:
                                          "คุณต้องการยกเลิกรายการนี้ใช่หรือไม่?",
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "ยกเลิก",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          onPressed: () => Navigator.pop(context),
                                          color: Colors.grey
                                        ),
                                        DialogButton(
                                          child: Text(
                                            "ตกลง",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(context, PageTo.indexScreen);
                                          },
                                          color: Colors.red,
                                        )
                                      ],
                                    ).show();
                                  },
                                  child: Container(
                                    height: _height * 0.1,
                                    width: _width,
                                    padding: EdgeInsets.all(_height * 0.01),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Card(
                                            elevation: 5,
                                            child: Container(
                                              alignment: Alignment.center,
                                              color: Colors.grey,
                                              child: Text(
                                                'ยกเลิกรายการ',
                                                style: TextStyle(
                                                    fontSize: _height * 0.023,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: _height * 0.01,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  PageTo
                                                      .transferSingleAgianScreen);
                                            },
                                            child: Card(
                                              elevation: 5,
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: Colors.red,
                                                child: Text(
                                                  'แก้ไขรายการใหม่',
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
                                )
                                //  InkWell(
                                //   onTap: () {

                                //   },
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       color: Colors.red,
                                //       borderRadius: BorderRadius.circular(30),
                                //     ),
                                //     alignment: Alignment.center,
                                //     child: Text(
                                //       'ทำรายการใหม่อีกครั้ง',
                                //       style: TextStyle(
                                //           fontSize: _height * 0.023,
                                //           color: Colors.white),
                                //     ),
                                //     width: _width,
                                //     height: _height * 0.07,
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: _height * 0.1,
                        width: _width,
                        child: Container(
                          alignment: Alignment.center,
                          height: _height * 0.1,
                          width: _width * 0.2,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: _height * 0.06,
                            child: Icon(
                              Icons.warning_amber_outlined,
                              color: Colors.white,
                              size: _height * 0.08,
                            ),
                          ),
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
    );
  }
}
