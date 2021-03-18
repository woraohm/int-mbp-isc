import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';

class CreateOrderTransferScreen extends StatefulWidget {
  String fromBankName;
  String fromAcctType;
  String fromAcctNumber;
  String toBankName;
  String toAcctName;

  String toAcctNumber;
  double toAmount;
  String toNote;
  String tracNo;
  String dateTime;
  double fee;

  CreateOrderTransferScreen(
      {this.toAcctNumber,
      this.toBankName,
      this.toAmount,
      this.toNote,

      this.toAcctName,
      this.fromAcctType,
      this.fromAcctNumber,
      this.fromBankName,
      this.dateTime,
      this.tracNo,
      this.fee});

  @override
  _CreateOrderTransferScreenState createState() =>
      _CreateOrderTransferScreenState(
        fromAcctNumber: fromAcctNumber,
        fromAcctType: fromAcctType,
        fromBankName: fromBankName,
        toAcctNumber: toAcctNumber,
        toBankName: toBankName,
        toAcctName: toAcctName,
    
        toAmount: toAmount,
        toNote: toNote,
        dateTime: dateTime,
        tracNo: tracNo,
        fee: fee,
      );
}

class _CreateOrderTransferScreenState extends State<CreateOrderTransferScreen> {
  String fromBankName = "";
  String fromAcctType = "";
  String fromAcctNumber = "";
  String toBankName = "";
  String toAcctName = "";

  String toAcctNumber = "";
  double toAmount;
  String toNote = "";
  String dateTime;
  String tracNo;
  double fee;
  _CreateOrderTransferScreenState(
      {this.toAcctNumber,
      this.toBankName,
      this.toAmount,
      this.toNote,
    
      this.toAcctName,
      this.fromAcctType,
      this.fromAcctNumber,
      this.fromBankName,
      this.tracNo,
      this.dateTime,
      this.fee});

  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  TextEditingController qrTextController = TextEditingController();
  GlobalKey globalKey = new GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();
  bool button1;

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
        return null;
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
        return "ธนาคารธนชาต";
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

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    final info = statuses[Permission.storage].toString();
    //_toastInfo(info);
  }

  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }

  _saveScreen() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result =
        await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
    print(result);
    _toastInfo("บันทึกสลิปลงเครื่องเรียบร้อยแล้ว");
  }

  @override
  void initState() {
    button1 = false;
    
    super.initState();
    _requestPermission();

    showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: "สร้างรายการสำเร็จ โปรดตรวจสอบสถานะการอนุมัติต่อไป",
        textStyle: TextStyle(fontSize: 20),
      ),
    );
    //_captureAndSharePng();
  }
  Future<Null> shareScreenshot() async {
    setState(() {
      button1 = true;
    });
    try {
      RenderRepaintBoundary boundary =
      globalKey.currentContext.findRenderObject();
      if (boundary.debugNeedsPaint) {
        Timer(Duration(seconds: 1), () => shareScreenshot());
        return null;
      }
      ui.Image image = await boundary.toImage();
      final directory = (await getExternalStorageDirectory()).path;
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      File imgFile = File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      final RenderBox box = context.findRenderObject();
      // Share.shareFiles('',
      // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      // Share.share('Hello, check your share files!',
      // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);

      Share.shareFile(File('$directory/screenshot.png'),
          subject: 'Share ScreenShot',

          text: 'Hello, check your share files!',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
      );
    } on PlatformException catch (e) {
      print("Exception while taking screenshot:" + e.toString());
    }
    setState(() {
      button1 = false;
    });
  }
  Future<bool> _onBackPressed() {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Are you sure?'),
      content: Text('Do you want to exit an App'),
      actions: <Widget>[
        GestureDetector(
          onTap: () => Navigator.of(context).pop(false),
          child: Text("NO"),
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () => Navigator.of(context)
                        .popUntil(ModalRoute.withName(PageTo.indexScreen)),
          child: Text("YES"),
        ),
      ],
    ),
  ) ??
      false;
}

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onBackPressed,
          child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFeaecf0),
          body: ListView(
            children: <Widget>[
              RepaintBoundary(
                key: globalKey,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: _height * 0.08,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: _width,
                        height: _height * 0.1,
                        child: Image.asset(
                            'assests/images/logo_isc_medium_purple.png'),
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.only(
                                left: _height * 0.02, right: _height * 0.02),
                            width: _width,
                            height: _height * 0.8,
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
                                height: _height * 0.75,
                                //color: Colors.green,
                                padding: EdgeInsets.only(
                                    left: _height * 0.02, right: _height * 0.02),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: _width,
                                      height: _height * 0.72,
                                      color: Colors.white,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: _height * 0.05,
                                          ),
                                          Container(
                                            width: _width,
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
                                                    'สร้างรายการสำเร็จ',
                                                    style: TextStyle(
                                                        fontSize: _height * 0.04,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ),
                                                Container(
                                                  height: _height * 0.03,
                                                  width: _width,
                                                  alignment: Alignment.topCenter,
                                                  child: Text(
                                                    dateTime,
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
                                                              width:
                                                                  _width * 0.15,
                                                              height: _height,
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: CircleAvatar(
                                                                backgroundImage:
                                                                fromBankName=='ไม่มีธนาคาร'?
                                                                AssetImage('assests/images/avatar-circle.png'):
                                                                    checkLogoBank(
                                                                        fromBankName),
                                                                backgroundColor:
                                                                    Colors.yellow,
                                                                radius: _height *
                                                                    0.03,
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  _width * 0.55,
                                                              height: _height,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  SizedBox(
                                                                    height:
                                                                        _height *
                                                                            0.01,
                                                                  ),
                                                                  Text(
                                                                    fromAcctType,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            _height *
                                                                                0.023),
                                                                  ),
                                                                  Text(
                                                                    fromAcctNumber,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            _height *
                                                                                0.02,
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
                                                              width:
                                                                  _width * 0.15,
                                                              height: _height,
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: CircleAvatar(
                                                                backgroundImage:toBankName==null?
                                                                AssetImage('assests/images/avatar-circle.png'):
                                                                    checkLogoBank(
                                                                        toBankName),
                                                                
                                                                radius: _height *
                                                                    0.03,
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  _width * 0.55,
                                                              height: _height,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  SizedBox(
                                                                    height:
                                                                        _height *
                                                                            0.01,
                                                                  ),
                                                                  Text(
                                                                    toAcctName,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            _height *
                                                                                0.023),
                                                                  ),
                                                                  Text(
                                                                    toAcctNumber,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            _height *
                                                                                0.02,
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
                                                              fontSize: _height *
                                                                  0.023),
                                                        ),
                                                        width: _width * 0.23,
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.centerRight,
                                                        height: _height,
                                                        width: _width * 0.57,
                                                        child: Text(
                                                          tracNo,
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
                                                              fontSize: _height *
                                                                  0.023),
                                                        ),
                                                        width: _width * 0.23,
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.centerRight,
                                                        height: _height,
                                                        width: _width * 0.5,
                                                        child: Text(
                                                          '${formatMoney.format(toAmount)}',
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
                                                              fontSize: _height *
                                                                  0.018),
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
                                                              fontSize: _height *
                                                                  0.023),
                                                        ),
                                                        width: _width * 0.23,
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.centerRight,
                                                        height: _height,
                                                        width: _width * 0.5,
                                                        child: Text(
                                                          '${formatMoney.format(fee)}',
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
                                                              fontSize: _height *
                                                                  0.018),
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
                                                              fontSize: _height *
                                                                  0.023),
                                                        ),
                                                        width: _width * 0.23,
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.centerRight,
                                                        height: _height,
                                                        width: _width * 0.57,
                                                        child: Text(
                                                          toNote,
                                                          style: TextStyle(
                                                              fontSize: _height *
                                                                  0.018),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: _width,
                                                  height: _height * 0.15,
                                                  padding: EdgeInsets.only(
                                                      left: _height * 0.02,
                                                      top: _height * 0.02),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          'ท่านสามารถสแกนคิวอาร์โค้ดนี้\nเพื่อตรวจสอบสถานะการโอนเงิน',
                                                          style: TextStyle(
                                                              fontSize: _height *
                                                                  0.023),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: _width * 0.25,
                                                        height: _height,
                                                        child: QrImage(
                                                          data: tracNo,
                                                        ),
                                                      ),
                                                      Container()
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Container(
                                    //   alignment: Alignment.bottomCenter,
                                    //   width: _width,
                                    //   height: _height * 0.085,
                                    // ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     _saveScreen();
                                    //   },
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.pink[300],
                                    //       borderRadius: BorderRadius.circular(30),
                                    //     ),
                                    //     alignment: Alignment.center,
                                    //     child: Text(
                                    //       'เสร็จสิ้น',
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
                                backgroundColor: Colors.white,
                                radius: _height * 0.05,
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: _height * 0.09,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                      InkWell(
                  onTap: () {
                    _saveScreen();
                  },
                  child: Card(
                    elevation: 5,
                    color: Color(0xFF9D4EDD),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    child: Container(
                      alignment: Alignment.center,
                      height: _height*0.08,
                      width: _width*0.4,
                      child: Text(
                        'บันทึกสลิป',
                        style: TextStyle(
                          fontSize: _height * 0.028,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                      shareScreenshot();
                  },
                  child: Card(
                    elevation: 5,
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    child: Container(
                      alignment: Alignment.center,
                      height: _height*0.08,
                      width: _width*0.4,
                      child: Text( 
                        'แชร์',
                        style: TextStyle(
                          fontSize: _height * 0.028,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                ],),
              ),
              Padding(
                padding:EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName(PageTo.indexScreen));
                  },
                  child: Card(
                    elevation: 5,
                    color: Color(0xFF3b074b),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    child: Container(
                      alignment: Alignment.center,
                      width: _width,
                      height: _height * 0.09,
                      child: Text(
                        'เสร็จสิ้น',
                        style: TextStyle(
                          fontSize: _height * 0.028,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
