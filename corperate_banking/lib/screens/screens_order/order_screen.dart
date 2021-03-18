import 'dart:convert';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/main.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screens_order/order-detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rest_package/bean/transf_order_request.dart';
import 'package:rest_package/bean/transf_order_response.dart';

import 'package:rest_package/connection/transf_order_connection.dart';

import 'package:rest_package/constant/response_code.dart';

import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/model/transf_order_model_response.dart';
import 'package:corperate_banking/global/global.dart' as globals;

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {






  FunctionGlobal func = FunctionGlobal();
  bool setAll = true;
  bool setApproval = false;
  bool setWaitCheck = false;
  bool setWaitApproval = false;
  bool setNotSuccess = false;
  String tracNo;


  XSignature randReqRefNo = XSignature();
  TransfOrderConnection transfOrderConnect =
      TransfOrderConnection(globals.iPV4, '8080');

  Future<List<TransfOrderModelResponse>> getOrderAll() async {
    List<TransfOrderModelResponse> resOrderAll = [];

    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetOrderAll: ' + reqRefNo);
    TransfOrderRequest request =
        TransfOrderRequest(reqRefNo: reqRefNo, trnStatusCode: 'All');

    await transfOrderConnect
        .transfOrderConnection(request, globals.token)
        .then((value) {
      //print('status code GetOrderAll= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfOrderResponse response =
            TransfOrderResponse.fromJson(responseMap);
        print("respDescCodeGetOrderAll: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (TransfOrderModelResponse data in response.listintMbpTxTransLog) {
            resOrderAll.add(data);
          }
        }
      }
    });
    return resOrderAll;
  }

  Future<List<TransfOrderModelResponse>> getOrderWaitApproval() async {
    List<TransfOrderModelResponse> resOrderWaitAproval = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetOrderWaitApproval: ' + reqRefNo);
    TransfOrderRequest request =
        TransfOrderRequest(reqRefNo: reqRefNo, trnStatusCode: "WAP");
    await transfOrderConnect
        .transfOrderConnection(request, globals.token)
        .then((value) {
      //print('status code GetOrderWaitApproval= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfOrderResponse response =
            TransfOrderResponse.fromJson(responseMap);
        print("respDescCodeGetOrderWaitApproval: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (TransfOrderModelResponse data in response.listintMbpTxTransLog) {
            resOrderWaitAproval.add(data);
          }
        }
      }
    });
    return resOrderWaitAproval;
  }

  Future<List<TransfOrderModelResponse>> getOrderApproved() async {
    List<TransfOrderModelResponse> resOrderWaitAproval = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetOrderApproved: ' + reqRefNo);
    TransfOrderRequest request =
        TransfOrderRequest(reqRefNo: reqRefNo, trnStatusCode: "AP");
    await transfOrderConnect
        .transfOrderConnection(request, globals.token)
        .then((value) {
      //print('status code GetOrderApproved= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfOrderResponse response =
            TransfOrderResponse.fromJson(responseMap);
        print("respDescCodeGetOrderApproved: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (TransfOrderModelResponse data in response.listintMbpTxTransLog) {
            resOrderWaitAproval.add(data);
          }
        }
      }
    });
    return resOrderWaitAproval;
  }

  Future<List<TransfOrderModelResponse>> getOrderWaitChecker() async {
    List<TransfOrderModelResponse> resOrderWaitChecker = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetOrderWaitChecker: ' + reqRefNo);
    TransfOrderRequest request =
        TransfOrderRequest(reqRefNo: reqRefNo, trnStatusCode: "WC");
    await transfOrderConnect
        .transfOrderConnection(request, globals.token)
        .then((value) {
      //print('status code GetOrderWaitChecker= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfOrderResponse response =
            TransfOrderResponse.fromJson(responseMap);
        print("respDescCodeGetOrderWaitChecker: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (TransfOrderModelResponse data in response.listintMbpTxTransLog) {
            resOrderWaitChecker.add(data);
          }
        }
      }
    });
    return resOrderWaitChecker;
  }

  Future<List<TransfOrderModelResponse>> getOrderCancles() async {
    List<TransfOrderModelResponse> resOrderCancles = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetOrderCancles: ' + reqRefNo);
    TransfOrderRequest request =
        TransfOrderRequest(reqRefNo: reqRefNo, trnStatusCode: "Cancle");
    await transfOrderConnect
        .transfOrderConnection(request, globals.token)
        .then((value) {
      //print('status code GetOrderCancles= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfOrderResponse response =
            TransfOrderResponse.fromJson(responseMap);
        print("respDescCodeGetOrderCancles: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (TransfOrderModelResponse data in response.listintMbpTxTransLog) {
            resOrderCancles.add(data);
          }
        }
      }
    });
    return resOrderCancles;
  }

  checkStatus(String status) {
    switch (status) {
      case 'Approved':
        return Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(8)),
          child: Text(
            'สำเร็จ',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        );
        break;
      case 'Waiting for Check':
        return Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: Colors.orange, borderRadius: BorderRadius.circular(8)),
          child: Text(
            'รอตวรจสอบ',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        );
        break;
      case 'Waiting for Approval':
        return Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: Colors.yellow[600],
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            'รออนุมัติ',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        );
        break;
      case 'Cancle By Maker':
        return Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(8)),
          child: Text(
            'ไม่สำเร็จ',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        );

        break;
      case 'Cancle By Checker':
        return Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(8)),
          child: Text(
            'ไม่สำเร็จ',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        );
        break;
      case 'Cancle By Authorizer':
        return Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(8)),
          child: Text(
            'ไม่สำเร็จ',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        );
        break;
      default:
    }
  }
  
  
  
  

  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => func.onBackPressed(context),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            backgroundColor: Color(0xFF3b074b),
            centerTitle: true,
            title: Text(
              'รายการ',
              style: TextStyle(fontSize: _height * 0.03),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                  width: _width, height: _height, color: Color(0xFFeaecf0)),
              
              Container(
                height: _height,
                width: _width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                        left: _height * 0.02,
                      ),
                      child: Text(
                        'รายการการโอน',
                        style: TextStyle(
                            fontSize: _height * 0.023,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(child: _buildButtomAllOrder(context)),
                        SizedBox(
                          width: _height * 0.005,
                        ),
                        Expanded(child: _buildButtonAprroved(context)),
                        SizedBox(
                          width: _height * 0.005,
                        ),
                        Expanded(child: _buildButtonWaitChecker(context)),
                        SizedBox(
                          width: _height * 0.005,
                        ),
                        Expanded(child: _buildButtonWaitApprovel(context)),
                        SizedBox(
                          width: _height * 0.005,
                        ),
                        Expanded(child: _buildButtonNotSuccess(context)),
                      ],
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: _height * 0.02,
                            ),
                            
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: _height * 0.13),
                  height: _height,
                  width: _width,
                  child: Container(
                    width: _width,
                    height: _height,
                    child: Stack(
                      children: <Widget>[
                        _buildVisibilityAllOrderData(context),
                        _buildVisibilityApprovedData(context),
                        _buildVisibilityWaitCheckerData(context),
                        _buildVisibilityWaitApprovelData(context),
                        _buildVisibilityNotSuccessData(context)
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtomAllOrder(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
     
        setState(() {
          setAll = true;
          setApproval = false;
          setWaitCheck = false;
          setWaitApproval = false;
          setNotSuccess = false;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: _height * 0.04,
        decoration: BoxDecoration(
            color: setAll == true ? Color(0xFF3b074b) : Colors.white,
            borderRadius: BorderRadius.circular(18)),
        child: Text(
          'ทั้งหมด',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: _height * 0.018,
              color: setAll == true ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildButtonAprroved(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        setState(() {
          setAll = false;
          setApproval = true;
          setWaitCheck = false;
          setWaitApproval = false;
          setNotSuccess = false;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: _height * 0.04,
        decoration: BoxDecoration(
            color: setApproval == true ? Color(0xFF3b074b) : Colors.white,
            borderRadius: BorderRadius.circular(18)),
        child: Text(
          'อนุมัติแล้ว',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: _height * 0.018,
              color: setApproval == true ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildButtonWaitChecker(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        setState(() {
          setAll = false;
          setApproval = false;
          setWaitCheck = true;
          setWaitApproval = false;
          setNotSuccess = false;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: _height * 0.04,
        decoration: BoxDecoration(
          color: setWaitCheck == true ? Color(0xFF3b074b) : Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          'รอการตรวจสอบ',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: _height * 0.018,
              color: setWaitCheck == true ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildButtonWaitApprovel(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        setState(() {
          setAll = false;
          setApproval = false;
          setWaitCheck = false;
          setWaitApproval = true;
          setNotSuccess = false;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: _height * 0.04,
        decoration: BoxDecoration(
          color: setWaitApproval == true ? Color(0xFF3b074b) : Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          'รอการอนุมัติ',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: _height * 0.018,
              color: setWaitApproval == true ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildButtonNotSuccess(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        setState(() {
          setAll = false;
          setApproval = false;
          setWaitCheck = false;
          setWaitApproval = false;
          setNotSuccess = true;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: _height * 0.04,
        decoration: BoxDecoration(
          color: setNotSuccess == true ? Color(0xFF3b074b) : Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          'ไม่สำเร็จ',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: _height * 0.018,
              color: setNotSuccess == true ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildVisibilityAllOrderData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: setAll,
      child: FutureBuilder<List<TransfOrderModelResponse>>(
        future: getOrderAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var orders = snapshot.data;
            if(orders.length==0){
              return Center(child: Text('ไม่มีข้อมูล',style: TextStyle(fontSize: _height*0.026),),);
            }
            int lengthOrders = orders.length;
            return ListView.builder(
              itemCount: lengthOrders,
              itemBuilder: (context, int index) {
                return Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderDetailScreen(
                                    tracNo: tracNo,
                                  ))),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: _height * 0.02,
                            right: _height * 0.02,
                            top: _height * 0.01,
                            bottom: _height * 0.01),
                        width: _width,
                        height: _height * 0.15,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(Jiffy(orders[index].dateTime).yMMMMEEEEdjm,
                                style: TextStyle(
                                  fontSize: _height * 0.023,
                                  color: Colors.grey,
                                )),
                            Text('เลขที่รายการ ' + orders[index].trace_No,
                                style: TextStyle(
                                  fontSize: _height * 0.028,
                                  color: Color(0xFF2a2a39),
                                )),
                            Text('ปลายทาง ' + orders[index].to_Acct_Name_Th,
                                style: TextStyle(
                                  fontSize: _height * 0.026,
                                  color: Color(0xFF2a2a39),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                checkStatus(orders[index].trnStatus),
                                InkWell(
                                  onTap: () {
                                    tracNo = orders[index].trace_No;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderDetailScreen(
                                                  tracNo: tracNo,
                                                )));
                                  },
                                  child: Text(
                                    'เพิ่มเติม >',
                                    style: TextStyle(
                                        color: Color(0xFF2a2a39),
                                        decoration: TextDecoration.underline),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.002,
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildVisibilityApprovedData(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: setApproval,
      child: FutureBuilder<List<TransfOrderModelResponse>>(
        future: getOrderApproved(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var orders = snapshot.data;
            if(orders.length==0){
              return Center(child: Text('ไม่มีข้อมูล',style: TextStyle(fontSize: _height*0.026),),);
            }
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: _height * 0.02,
                          right: _height * 0.02,
                          top: _height * 0.01,
                          bottom: _height * 0.01),
                      width: _width,
                      height: _height * 0.15,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(Jiffy(orders[index].dateTime).yMMMMEEEEdjm,
                              style: TextStyle(
                                fontSize: _height * 0.023,
                                color: Colors.grey,
                              )),
                          Text('เลขที่รายการ ' + orders[index].trace_No,
                              style: TextStyle(
                                fontSize: _height * 0.028,
                                color: Color(0xFF2a2a39),
                              )),
                          Text('ปลายทาง ' + orders[index].to_Acct_Name_Th,
                              style: TextStyle(
                                fontSize: _height * 0.026,
                                color: Color(0xFF2a2a39),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              checkStatus(orders[index].trnStatus),
                              InkWell(
                                onTap: () {
                                  tracNo = orders[index].trace_No;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetailScreen(
                                                tracNo: tracNo,
                                              )));
                                },
                                child: Text(
                                  'เพิ่มเติม >',
                                  style: TextStyle(
                                      color: Color(0xFF2a2a39),
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.002,
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildVisibilityWaitCheckerData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: setWaitCheck,
      child: FutureBuilder<List<TransfOrderModelResponse>>(
        future: getOrderWaitChecker(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var orders = snapshot.data;
            if(orders.length==0){
              return Center(child: Text('ไม่มีข้อมูล',style: TextStyle(fontSize: _height*0.026),),);
            }
            int lengthOrders = orders.length;
            return ListView.builder(
              itemCount: lengthOrders,
              itemBuilder: (context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: _height * 0.02,
                          right: _height * 0.02,
                          top: _height * 0.01,
                          bottom: _height * 0.01),
                      width: _width,
                      height: _height * 0.15,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(Jiffy(orders[index].dateTime).yMMMMEEEEdjm,
                              style: TextStyle(
                                fontSize: _height * 0.023,
                                color: Colors.grey,
                              )),
                          Text('เลขที่รายการ ' + orders[index].trace_No,
                              style: TextStyle(
                                fontSize: _height * 0.028,
                                color: Color(0xFF2a2a39),
                              )),
                          Text('ปลายทาง ' + orders[index].to_Acct_Name_Th,
                              style: TextStyle(
                                fontSize: _height * 0.026,
                                color: Color(0xFF2a2a39),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              checkStatus(orders[index].trnStatus),
                              InkWell(
                                onTap: () {
                                  tracNo = orders[index].trace_No;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetailScreen(
                                                tracNo: tracNo,
                                              )));
                                },
                                child: Text(
                                  'เพิ่มเติม >',
                                  style: TextStyle(
                                      color: Color(0xFF2a2a39),
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.002,
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildVisibilityWaitApprovelData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: setWaitApproval,
      child: FutureBuilder<List<TransfOrderModelResponse>>(
        future: getOrderWaitApproval(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var orders = snapshot.data;
            if(orders.length==0){
              return Center(child: Text('ไม่มีข้อมูล',style: TextStyle(fontSize: _height*0.026),),);
            }
            int lengthOrders = orders.length;
            return ListView.builder(
              itemCount: lengthOrders,
              itemBuilder: (context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: _height * 0.02,
                          right: _height * 0.02,
                          top: _height * 0.01,
                          bottom: _height * 0.01),
                      width: _width,
                      height: _height * 0.15,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(Jiffy(orders[index].dateTime).yMMMMEEEEdjm,
                              style: TextStyle(
                                fontSize: _height * 0.023,
                                color: Colors.grey,
                              )),
                          Text('เลขที่รายการ ' + orders[index].trace_No,
                              style: TextStyle(
                                fontSize: _height * 0.028,
                                color: Color(0xFF2a2a39),
                              )),
                          Text('ปลายทาง ' + orders[index].to_Acct_Name_Th,
                              style: TextStyle(
                                fontSize: _height * 0.026,
                                color: Color(0xFF2a2a39),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              checkStatus(orders[index].trnStatus),
                              InkWell(
                                onTap: () {
                                  tracNo = orders[index].trace_No;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetailScreen(
                                                tracNo: tracNo,
                                              )));
                                },
                                child: Text(
                                  'เพิ่มเติม >',
                                  style: TextStyle(
                                      color: Color(0xFF2a2a39),
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.002,
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildVisibilityNotSuccessData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: setNotSuccess,
      child: FutureBuilder<List<TransfOrderModelResponse>>(
        future: getOrderCancles(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var orders = snapshot.data;
            if(orders.length==0){
              return Center(child: Text('ไม่มีข้อมูล',style: TextStyle(fontSize: _height*0.026),),);
            }
            int lengthOrders = orders.length;
            return ListView.builder(
              itemCount: lengthOrders,
              itemBuilder: (context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: _height * 0.02,
                          right: _height * 0.02,
                          top: _height * 0.01,
                          bottom: _height * 0.01),
                      width: _width,
                      height: _height * 0.15,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(Jiffy(orders[index].dateTime).yMMMMEEEEdjm,
                              style: TextStyle(
                                fontSize: _height * 0.023,
                                color: Colors.grey,
                              )),
                          Text('เลขที่รายการ ' + orders[index].trace_No,
                              style: TextStyle(
                                fontSize: _height * 0.028,
                                color: Color(0xFF2a2a39),
                              )),
                          Text('ปลายทาง ' + orders[index].to_Acct_Name_Th,
                              style: TextStyle(
                                fontSize: _height * 0.026,
                                color: Color(0xFF2a2a39),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              checkStatus(orders[index].trnStatus),
                              InkWell(
                                onTap: () {
                                  tracNo = orders[index].trace_No;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetailScreen(
                                                tracNo: tracNo,
                                              )));
                                },
                                child: Text(
                                  'เพิ่มเติม >',
                                  style: TextStyle(
                                      color: Color(0xFF2a2a39),
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.002,
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
