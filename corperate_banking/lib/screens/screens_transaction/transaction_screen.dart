import 'dart:convert';

import 'package:backdrop/backdrop.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:corperate_banking/screens/accounts_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_scan/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:rest_package/bean/transf_order_detail_request.dart';
import 'package:rest_package/bean/transf_order_detail_response.dart';
import 'package:rest_package/connection/transf_order_detail_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:sweetalert/sweetalert.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}


class _TransactionScreenState extends State<TransactionScreen> {
  String barcode;
  TransfOrderDetailConnection transfOrderDetailConnect =
      TransfOrderDetailConnection(globals.iPV4, '8080');
  XSignature randReqRefNo = XSignature();
  Future<void> checkGetOrderDetail(String data) async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNocheckGetOrderDetail: ' + reqRefNo);
    TransfOrderDetailRequest request =
        TransfOrderDetailRequest(reqRefNo: reqRefNo, traceNo: data);
    await transfOrderDetailConnect
        .transfOrderDetailConnection(request, globals.token)
        .then((value) {
      //print('status code checkGetOrderDetail= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfOrderDetailResponse response =
            TransfOrderDetailResponse.fromJson(responseMap);
        print("respDescCodecheckGetOrderDetail: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ScanDataTransfScreen(tracNo: response.traceNo,)));
        }else{
          SweetAlert.show(
            context,
            title: "Unable to proceed",
            confirmButtonColor: Color(0xFF3b074b),
            subtitle: "Cannot decode this barcode/QR code",
            style: SweetAlertStyle.error,
            
            );
          
        }
      }
    });
    
  }
  Future scanNow() async {
    try {
      ScanResult barcode = await BarcodeScanner.scan();
      String data=barcode.rawContent;
      print("=================");
      print(data);
      checkGetOrderDetail(data);
      print("=================");
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'ไม่มีสิทธิ์ใช้งานกล้อง';
        });
      } else {
        setState(() => this.barcode = 'Unknow error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null ( User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          //appBar: _buildAppBar(context, _height),
          body: Container(
        width: _width,
        height: _height,
        color: Color(0xFFCFCFCF),
        child: Stack(
          children: <Widget>[
            Container(
              height: _height,
              width: _width,
              child: Image.asset('assests/images/background_transaction.JPG',fit: BoxFit.cover,),
            ),
            Container(
                height: _height,
                width: _width,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: _height * 0.02, right: _height * 0.02),
                      width: _width,
                      height: _height * 0.13,
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            width: _width * 0.1,
                            height: _height,
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Color(0xFF3b074b),
                                ),
                                onPressed: () => Navigator.pop(context)),
                          ),
                          _buildHeaderImage(context, _height, _width),
                          // SizedBox(
                          //   width: _height * 0.01,
                          // ),
                          _buildHeaderInfo(context, _height, _width)
                        ],
                      ),
                    ),
                    Container(
                        alignment: Alignment.topRight,
                        // padding: EdgeInsets.only(
                        //    // left: _height * 0.01, right: _height * 0.03),
                        child: Container(
                          decoration: BoxDecoration(
                              //borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          padding: EdgeInsets.only(
                              left: _height * 0.01, right: _height * 0.01),
                          child: Text(
                            'การทำธรุกรรม',
                            style: TextStyle(
                                color: Color(0xFF3b074b), fontSize: _height * 0.025),
                          ),
                        )),
                    Container(
                      height: _height * 0.003,
                      width: _width,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    Container(
                      height: _height * 0.7,
                      width: _width,
                      padding: EdgeInsets.only(
                          left: _height * 0.04, right: _height * 0.04),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _buildTransactionMenu(
                                    context, "สร้างรายการโอนเงิน"),
                                _buildTransactionMenu(
                                    context, 'เพิ่มบัญชีโปรด'),
                                _buildTransactionMenu(
                                    context, 'เพิ่มบัญชีบุคคลอื่น'),
                                //_buildTransactionMenu(context, 'รายการล่าสุด'),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: _height * 0.02,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  _buildTransactionMenu(
                                      context, 'รายการล่าสุด'),
                                  _buildTransactionMenu(context, 'สแกน'),
                                  _buildTransactionMenu(context, 'โอนหลายรายการ'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    // Column(
                    //   children: <Widget>[
                    //     _buildTransactionMenu(
                    //         context, 'สร้างรายการโอนเงิน'),
                    //     // _buildTransactionMenu(context, 'เพิ่มบัญชีโปรด'),
                    //     // _buildTransactionMenu(context, 'เพิ่มบัญชีบุคคลอื่น'),
                    //     // _buildTransactionMenu(context, 'รายการล่าสุด'),

                    //   ],
                    // ),
                  ],
                ))

            //   _buildHeaderBackgroundImage(context, _height, _width),
            //   Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       SizedBox(
            //         width: _height * 0.02,
            //       ),
            //       Container(
            //           alignment: Alignment.center,
            //           height: _height * 0.2,
            //           width: _width * 0.3,
            //           child: _buildHeaderImage(context, _height, _width)),
            //       Container(
            //           padding: EdgeInsets.all(_height * 0.01),
            //           alignment: Alignment.centerLeft,
            //           height: _height * 0.2,
            //           width: _width * 0.65,
            //           child: _buildHeaderInfo(context, _height, _width))
            //     ],
            //   ),
            //   Column(
            //     children: <Widget>[
            //       SizedBox(
            //         height: _height * 0.2,
            //       ),
            //       Container(
            //           padding: EdgeInsets.only(
            //               left: _height * 0.035,
            //               right: _height * 0.02,
            //               top: _height * 0.01),
            //           height: _height * 0.54,
            //           width: _width,
            //           child: Column(
            //             children: <Widget>[
            //               Container(
            //                   child: Row(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: <Widget>[
            //                   InkWell(
            //                     onTap: () {
            //                       Navigator.pushNamed(
            //                           context, PageTo.numpadTransferScreen);
            //                     },
            //                     child: Card(
            //                       shape: RoundedRectangleBorder(
            //                           borderRadius:
            //                               BorderRadius.circular(10)),
            //                       elevation: 5,
            //                       child: Container(
            //                         alignment: Alignment.center,
            //                         width: _width * 0.25,
            //                         height: _height * 0.1,
            //                         child: Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           children: <Widget>[
            //                             Icon(
            //                               Icons.alt_route,
            //                               color: Colors.red,
            //                               size: _height * 0.05,
            //                             ),
            //                             Text(
            //                               'โอนเงิน',
            //                               style: TextStyle(
            //                                   fontSize: _height * 0.023),
            //                             )
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: _height * 0.01,
            //                   ),
            //                   InkWell(
            //                     onTap: () {
            //                       Navigator.pushNamed(
            //                           context, PageTo.addFavouriteScreen);
            //                     },
            //                     child: Card(
            //                       shape: RoundedRectangleBorder(
            //                           borderRadius:
            //                               BorderRadius.circular(10)),
            //                       elevation: 5,
            //                       child: Container(
            //                         width: _width * 0.25,
            //                         height: _height * 0.1,
            //                         child: Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           children: <Widget>[
            //                             Icon(
            //                               Icons.add_circle,
            //                               color: Colors.red,
            //                               size: _height * 0.05,
            //                             ),
            //                             Text(
            //                               'เพิ่มบัญชีโปรด',
            //                               style: TextStyle(
            //                                   fontSize: _height * 0.023),
            //                             )
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: _height * 0.01,
            //                   ),
            //                   InkWell(
            //                     onTap: () {
            //                       Navigator.pushNamed(
            //                           context, PageTo.addAccountScreen);
            //                     },
            //                     child: Card(
            //                       shape: RoundedRectangleBorder(
            //                           borderRadius:
            //                               BorderRadius.circular(10)),
            //                       elevation: 5,
            //                       child: Container(
            //                         width: _width * 0.25,
            //                         height: _height * 0.1,
            //                         child: Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           children: <Widget>[
            //                             Icon(
            //                               Icons.add_circle_outline,
            //                               color: Colors.red,
            //                               size: _height * 0.05,
            //                             ),
            //                             Text(
            //                               'เพิ่มบัญชีผู้อื่น',
            //                               style: TextStyle(
            //                                   fontSize: _height * 0.023),
            //                             )
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),

            //               ),
            //               Container(
            //                   child: Row(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: <Widget>[
            //                   InkWell(
            //                     onTap: () {
            //                       Navigator.pushNamed(context, PageTo.homeScreen);

            //                     },
            //                     child: Card(
            //                       shape: RoundedRectangleBorder(
            //                           borderRadius:
            //                               BorderRadius.circular(10)),
            //                       elevation: 5,
            //                       child: Container(
            //                         alignment: Alignment.center,
            //                         width: _width * 0.25,
            //                         height: _height * 0.1,
            //                         child: Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           children: <Widget>[
            //                             Icon(
            //                               Icons.history,
            //                               color: Colors.red,
            //                               size: _height * 0.05,
            //                             ),
            //                             Text(
            //                               'รายการล่าสุด',
            //                               style: TextStyle(
            //                                   fontSize: _height * 0.023),
            //                             )
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: _height * 0.01,
            //                   ),
            //                   InkWell(
            //                     onTap: () {

            //                     },
            //                     child: Card(
            //                       color: Colors.transparent,
            //                       shape: RoundedRectangleBorder(
            //                           borderRadius:
            //                               BorderRadius.circular(10)),
            //                       elevation: 5,
            //                       child: Container(

            //                         width: _width * 0.25,
            //                         height: _height * 0.1,
            //                         child: Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           children: <Widget>[
            //                             // Icon(
            //                             //   Icons.add_circle,
            //                             //   color: Colors.red,
            //                             //   size: _height * 0.05,
            //                             // ),
            //                             // Text(
            //                             //   'เพิ่มบัญชีโปรด',
            //                             //   style: TextStyle(
            //                             //       fontSize: _height * 0.023),
            //                             // )
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: _height * 0.01,
            //                   ),

            //                 ],
            //               ),
            //               ),

            //             ],
            //           ))
            //     ],
            //   )
          ],
        ),
      )),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    double _height,
  ) {
    return AppBar(
        backgroundColor: Colors.pink[300],
        centerTitle: true,
        leading: Container(),
        title: Text(
          'ธุรกรรม',
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }

  Widget _buildHeaderBackgroundImage(
      BuildContext context, double _height, double _width) {
    return Container(
      height: _height * 0.2,
      width: _width,
      child: Image.asset(
        'assests/images/Capture1.png',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildHeaderImage(
      BuildContext context, double _height, double _width) {
    return CircleAvatar(
      radius: _height * 0.04,
      backgroundColor: Color(0xFFF4F0F9),
      backgroundImage: AssetImage('assests/images/avatar-circle.png'),
    );
  }

  Widget _buildHeaderInfo(BuildContext context, double _height, double _width) {
    return Container(
     
      padding: EdgeInsets.only(
          left: _height * 0.01, right: _height * 0.01, top: _height * 0.015),
      alignment: Alignment.centerLeft,
      width: _width * 0.6,
      height: _height * 0.16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            globals.staffFname + ' ' + globals.staffLname,
            style: TextStyle(color: Colors.black, fontSize: _height * 0.02),
          ),
          Text(
            'สถานะ: ' + globals.staffThem,
            style: TextStyle(color: Colors.black, fontSize: _height * 0.023),
          ),
          Text(
            'เข้าสู่ระบบครั้งล่าสุด: ' + '17 ตุลาคม 2564 20:51',
            style: TextStyle(color: Colors.black, fontSize: _height * 0.02),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionMenu(BuildContext context, String name) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        InkWell(
          onTap: () {
            checkNavigator(name);
          },
          child: Container(
            alignment: Alignment.center,
            width: _width * 0.15,
            height: _height * 0.1,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: name == "" ? Colors.transparent : Color(0xFF3b074b)),
            child: checkIconMenu(context, name),
          ),
        ),
        Text(
          name,
          style: TextStyle(fontSize: _height * 0.02),
        )
      ],
    );
    //   children: [
    //     Stack(
    //       children: <Widget>[
    //         Padding(
    //           padding:
    //               EdgeInsets.only(left: _height * 0.08, right: _height * 0.02),
    //           child: Card(
    //             elevation: 2,
    //             color: Colors.white,
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(12)),
    //             child: Container(
    //               alignment: Alignment.center,
    //               width: _width,
    //               height: _height * 0.1,
    //               child: ListTile(
    //                 leading: Text(''),
    //                 title: Text(
    //                   name,
    //                   style: TextStyle(fontSize: _height * 0.024),
    //                 ),
    //                 trailing: Icon(
    //                   Icons.arrow_forward_ios,
    //                   size: _height * 0.023,
    //                   color: Colors.pink,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(top: _height * 0.013),
    //           child: Container(
    //             padding: EdgeInsets.only(
    //                 left: _height * 0.01, right: _height * 0.02),
    //             alignment: Alignment.topLeft,
    //             width: _width,
    //             height: _height * 0.08,
    //             child: Container(
    //               alignment: Alignment.center,
    //               width: _width * 0.3,
    //               decoration:
    //                   BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
    //               child: Container(
    //                   alignment: Alignment.center,
    //                   width: _width * 0.16,
    //                   decoration: BoxDecoration(
    //                       shape: BoxShape.circle, color: Colors.white),
    //                   child: checkIconMenu(context, name)),
    //             ),
    //           ),
    //         ),

    //         // Icon(Icons.alt_route,size: _height*0.05,color: Colors.pink,),
    //       ],
    //     ),
    //     SizedBox(
    //       height: _height * 0.01,
    //     )
    //   ],
    // );
  }

  checkIconMenu(BuildContext context, String name) {
    final double _height = MediaQuery.of(context).size.height;
    switch (name) {
      case 'สร้างรายการโอนเงิน':
        return Icon(
          Icons.alt_route,
          size: _height * 0.05,
          color: Colors.white,
        );
        break;
      case 'เพิ่มบัญชีโปรด':
        return Icon(
          Icons.add_circle,
          size: _height * 0.05,
          color: Colors.white,
        );
        break;
      case 'เพิ่มบัญชีบุคคลอื่น':
        return Icon(Icons.add_circle_outline,
            size: _height * 0.05, color: Colors.white);
        break;
      case 'รายการล่าสุด':
        return Icon(
          Icons.history,
          size: _height * 0.05,
          color: Colors.white,
        );
        break;
      case 'สแกน':
        return Icon(
          Icons.qr_code_sharp,
          size: _height * 0.05,
          color: Colors.white,
        );
        break;
      case 'โอนหลายรายการ':
        return Icon(
          Icons.mediation_outlined,
          size: _height * 0.05,
          color: Colors.white,
        );
        break;
      default:
    }
  }

  checkNavigator(String name) {
    switch (name) {
      case "สร้างรายการโอนเงิน":
        return Navigator.pushNamed(context, PageTo.numpadTransferScreen);
        break;
      case "เพิ่มบัญชีโปรด":
        return Navigator.pushNamed(context, PageTo.addFavouriteScreen);
        break;
      case "เพิ่มบัญชีบุคคลอื่น":
        return Navigator.pushNamed(context, PageTo.addAccountScreen);
        break;
      case "รายการล่าสุด":
        return Navigator.pushNamed(context, PageTo.homeScreen);
        break;
      case "สแกน":
        return scanNow();
        break;
      case "โอนหลายรายการ":
        return Navigator.pushNamed(context, PageTo.selectGroupScreen);

      default:
    }
  }

  // Widget _buildTransaction(
  //     BuildContext context, double _height, double _width) {
  //   return Card(
  //     elevation: 5,
  //     child: Container(
  //       width: _width * 0.25,
  //       height: _height * 0.1,
  //     ),
  //   );
  // }
}

// backgroundColor: Color(0xFFCFCFCF),
// resizeToAvoidBottomPadding: false,
// body: LayoutBuilder(
//   builder: (context, constrain) {
//     return Container(
//       height: _height,
//       width: _width,
//       padding: EdgeInsets.only(
//           // left: _height * 0.015,
//           // right: _height * 0.015,
//           //top:_height*0.038,
//           // bottom: _height*0.02,
//           ),
//       child: Column(children: <Widget>[
//         Stack(
//           children: <Widget>[
//             Container(
//               height: _height * 0.3,
//               width: _width,
//               child: Stack(
//                 children: <Widget>[
//                   Container(
//                     height: _height * 0.22,
//                     width: _width,
//                     child: Image.asset(
//                       'assests/images/Capture1.png',
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.topLeft,
//                     child: IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(
//                         Icons.arrow_back_ios,

//                       ),
//                       iconSize: _height * 0.023,
//                     ),
//                   ),
//                   Container(
//                     height: _height * 0.22,
//                     width: _width,
//                     padding: EdgeInsets.only(
//                         left: _height * 0.06,
//                         right: _height * 0.06,
//                         top: _height * 0.02,
//                         bottom: _height * 0.04),
//                     child: Card(
//                       color: Colors.transparent,
//                       child: Container(
//                         child: Center(
//                           child: Column(
//                             children: <Widget>[
//                               SizedBox(
//                                 height: _height * 0.02,
//                               ),
//                               Container(
//                                 child: Text(
//                                   'สวัสดี',
//                                   style: TextStyle(
//                                       fontSize: _height * 0.025,
//                                       color: Colors.white),
//                                 ),
//                               ),
//                               Container(
//                                 child: Text(
//                                   globals.staffFname+' '+globals.staffLname,
//                                   style: TextStyle(
//                                       fontSize: _height * 0.025,
//                                       color: Colors.white),
//                                 ),
//                               ),
//                               Container(
//                                   child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   Container(
//                                     child: Text(
//                                       'สถานะ: ',
//                                       style: TextStyle(
//                                           fontSize: _height * 0.025,
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                   Container(
//                                     child: Text(
//                                       globals.staffThem,
//                                       style: TextStyle(
//                                           fontSize: _height * 0.025,
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                 ],
//                               )),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: _height,
//                     width: _width,
//                     padding: EdgeInsets.only(top: _height * 0.14),
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Container(
//                         alignment: Alignment.center,
//                         height: _height / 10,
//                         width: _height / 10,
//                         decoration: BoxDecoration(
//                           color: Color(0xff474546),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Column(
//                           children: <Widget>[
//                             CircleAvatar(
//                               radius: _height * 0.05,
//                               backgroundImage:
//                                  NetworkImage(globals.staffProfile)
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//         Container(
//           padding: EdgeInsets.only(
//               left: _height * 0.02, right: _height * 0.02),
//           height: _height * 0.6,
//           width: _width,
//           child: Column(
//             children: <Widget>[
//               Container(
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: Card(
//                         child: Container(
//                           alignment: Alignment.center,
//                           height: _height * 0.12,
//                           width: _width * 0.24,
//                           child: Column(
//                             children: <Widget>[
//                               SizedBox(
//                                 height: _height * 0.01,
//                               ),
//                               Icon(
//                                 Icons.credit_card,
//                                 size: _height * 0.08,
//                                 color: Colors.red,
//                               ),
//                               Text(
//                                 'หน้ารวมบัญชี',
//                                 style: TextStyle(
//                                     fontSize: _height * 0.02,
//                                     fontWeight: FontWeight.normal),
//                               )
//                             ],
//                           ),
//                         ),
//                         elevation: 5,
//                       ),
//                     ),
//                     SizedBox(
//                       width: _height * 0.01,
//                     ),
//                     Expanded(
//                       child: Card(
//                         elevation: 5,
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.pushNamed(
//                                 context, PageTo.numpadTransferScreen);
//                           },
//                           child: Container(
//                             height: _height * 0.12,
//                             width: _width * 0.24,
//                             child: Column(
//                               children: <Widget>[
//                                 SizedBox(
//                                   height: _height * 0.01,
//                                 ),
//                                 Icon(
//                                   Icons.alt_route,
//                                   size: _height * 0.08,
//                                   color: Colors.red,
//                                 ),
//                                 Text(
//                                   'โอนเงิน',
//                                   style: TextStyle(
//                                       fontSize: _height * 0.02,
//                                       fontWeight: FontWeight.normal),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: _height * 0.01,
//                     ),
//                     Expanded(
//                       child: Card(
//                         elevation: 5,
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.pushNamed(context,PageTo.addFavouriteScreen);
//                           },
//                           child: Container(
//                             height: _height * 0.12,
//                             width: _width * 0.24,
//                             child: Column(
//                               children: <Widget>[
//                                 SizedBox(
//                                   height: _height * 0.01,
//                                 ),
//                                 Icon(
//                                   Icons.add,
//                                   size: _height * 0.08,
//                                   color: Colors.red,
//                                 ),
//                                 Text(
//                                   'เพิ่มรายการโปรด',
//                                   style: TextStyle(
//                                       fontSize: _height * 0.02,
//                                       fontWeight: FontWeight.normal),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: _height * 0.01,
//               ),
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: Card(
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.pushNamed(context, PageTo.addOtherAccountScreen);
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           height: _height * 0.12,
//                           width: _width * 0.24,
//                           child: Column(
//                             children: <Widget>[
//                               SizedBox(
//                                 height: _height * 0.01,
//                               ),
//                               Icon(
//                                 Icons.add_box,
//                                 size: _height * 0.08,
//                                 color: Colors.red,
//                               ),
//                               Text(
//                                 'เพิ่มบัญชีบุคคลอื่น',
//                                 style: TextStyle(
//                                     fontSize: _height * 0.02,
//                                     fontWeight: FontWeight.normal),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       elevation: 5,
//                     ),
//                   ),
//                   SizedBox(
//                     width: _height * 0.01,
//                   ),
//                   Expanded(
//                     child: Card(
//                       elevation: 5,
//                       color: Colors.white,
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.pushNamed(context, PageTo.addPromptpayScreen);
//                         },
//                         child: Container(
//                           height: _height * 0.12,
//                           width: _width * 0.24,
//                           child: Column(
//                             children: <Widget>[
//                               SizedBox(
//                                 height: _height * 0.01,
//                               ),
//                               Icon(Icons.add_circle,
//                               size: _height * 0.08,
//                                 color: Colors.red,),
//                               Text(
//                                 'เพิ่มบัญชีพร้อมเพย์',
//                                 style: TextStyle(
//                                     fontSize: _height * 0.02,
//                                     fontWeight: FontWeight.normal),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: _height * 0.01,
//                   ),
//                   Expanded(
//                     child: Card(
//                       color: Colors.grey,
//                       elevation: 5,
//                       child: InkWell(
//                         onTap: () {},
//                         child: Container(
//                           height: _height * 0.12,
//                           width: _width * 0.24,
//                           child: Column(
//                             children: <Widget>[
//                               SizedBox(
//                                 height: _height * 0.01,
//                               ),
//                               Text(
//                                 '',
//                                 style: TextStyle(
//                                     fontSize: _height * 0.02,
//                                     fontWeight: FontWeight.normal),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         )
//       ]),
//     );
//   },
// ),
