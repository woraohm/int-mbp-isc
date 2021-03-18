import 'dart:convert';

import 'package:backdrop/backdrop.dart';
import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:rest_package/bean/graph_request.dart';
import 'package:rest_package/bean/graph_response.dart';
import 'package:rest_package/bean/graph_show_response.dart';
import 'package:rest_package/bean/logout_request.dart';
import 'package:rest_package/bean/logout_response.dart';
import 'package:rest_package/bean/ostdTotal_request.dart';
import 'package:rest_package/bean/ostdTotal_response.dart';
import 'package:rest_package/connection/graph_connection.dart';
import 'package:rest_package/connection/logout_connection.dart';
import 'package:rest_package/connection/ostdTotal_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';

class AuthorizerHomeScreen extends StatefulWidget {
  @override
  _AuthorizerHomeScreenState createState() => _AuthorizerHomeScreenState();
}

class _AuthorizerHomeScreenState extends State<AuthorizerHomeScreen> {
  FunctionGlobal func = FunctionGlobal();
  GraphConnection graphConnect = GraphConnection(globals.iPV4, '8080');
  OSTDTotalConnection ostdTotalConnect =
      OSTDTotalConnection(globals.iPV4, '8080');
  XSignature randReqRefNo = XSignature();
  LogoutConnection logout = LogoutConnection(globals.iPV4, '8080');
  final formatMoney = new NumberFormat("#,##0.00", "en_US");
   List<Color> colorList = [
    Color(0xFFe09a16),
    Colors.orange[800],
    Color(0xFFefc41a),
  ];
  
  Future<double> getOSTDTotal() async {
    double ostdTotal;
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoSumOstd: ' + reqRefNo);
    OSTDTotalRequest request = OSTDTotalRequest(reqRefNo: reqRefNo);
    await ostdTotalConnect
        .connectOSTDTotal(request, globals.token)
        .then((value) {
      //print('status code getOSTDTotal= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: '+value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        OSTDTotalResponse response = OSTDTotalResponse.fromJson(responseMap);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          ostdTotal = response.sumOstdBalance;
        }
      }
    });

    return ostdTotal;
  }

  Future<Map<String, double>> getGraph() async {
    Map<String, double> getGraphMap = {};
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    print('reqRefNGraph: ' + reqRefNo);
    GraphRequest request = GraphRequest(reqRefNo: reqRefNo);
    await graphConnect.connectGraph(request, globals.token).then((value) {
      print('status code getGraph= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: '+value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        GraphShowResponse response = GraphShowResponse.fromJson(responseMap);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (GraphResponse data in response.accountList) {
            //print(data.accType + ' ' + data.ostdBalance.toString());
            getGraphMap[data.accType] = data.ostdBalance;
          }
        }
      }
    });

    return getGraphMap;
  }

 
  
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()=>func.onBackPressed(context),
          child: SafeArea(
        child: BackdropScaffold(
          appBar: _buildBackdropAppBar(context),
          headerHeight: _height * 0.62,
          frontLayer: Stack(
            children: <Widget>[
              Container(
                height: _height * 0.4,
                width: _width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black,backgroundMainColor])),
              ),
              Container(
                  // alignment: FractionalOffset.bottomLeft,
                  padding: EdgeInsets.only(
                      left: _height * 0.02,
                      right: _height * 0.02,
                      bottom: _height * 0.06,
                      top: _height * 0.01),
                  height: _height,
                  width: _width,
                  // decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //         begin: Alignment.topCenter,
                  //         end: Alignment.bottomCenter,
                  //         colors: [Colors.white, Color(0xFFCFCFCF)])),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _buildMenu(context,"รายการรออนุมัติ"),
                            _buildMenu(context, "ประวัติการอนุมัติ"),
                            _buildMenu(context, "การตั้งค่า")
                          ],
                        ),
                        // Card(
                        //   color: Colors.white,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(12)),
                        //   elevation: 10,
                        //   child: Container(
                        //     width: _width,
                        //     height: _height * 0.025,
                        //   ),
                        // ),
                      ],
                    ),
                  )),
              Container(
                padding: EdgeInsets.only(
                    left: _height * 0.02,
                    right: _height * 0.02,
                    top: _height * 0.02),
                height: _height,
                width: _width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'ยอดรวมสินทรัพย์',
                      style: TextStyle(
                          fontSize: _height * 0.028, fontWeight: FontWeight.w500,color: Colors.white),
                    ),
                    FutureBuilder<double>(
                      future: getOSTDTotal(),
                      builder: (context,snapshot){
                        if(!snapshot.hasData){
                          return Center(child: CircularProgressIndicator(),);
                        }else{
                          var data = snapshot.data;
                          return Text(
                        '${formatMoney.format(data)}' + ' บาท',
                        style: TextStyle(
                            fontSize: _height * 0.023, fontWeight: FontWeight.w500,color: Colors.white),
                      );
                        }
                      },
                                  
                    ),
                    Container(
                  padding: EdgeInsets.only(
                    left: _height * 0.02,
                    right: _height * 0.02,
                    // top: _height * 0.01,
                    // bottom: _height * 0.01,
                  ),
                  height: _height * 0.23,
                  width: _width,
                  child: FutureBuilder<Map<String, double>>(
                    future: getGraph(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        var graph = snapshot.data;

                        return PieChart(
                          dataMap: graph,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: _height * 0.05,
                          chartRadius: _height * 0.15,
                          colorList: colorList,
                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          ringStrokeWidth: _height * 0.01,
                          centerText: "",
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.right,
                            showLegends: true,
                            legendShape: BoxShape.circle,
                            legendTextStyle: TextStyle(
                                fontFamily: 'ThaiSansNeue',
                                fontSize: _height * 0.023,color: Colors.white),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: false,
                            showChartValues: false,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                          ),
                        );
                      }
                    },
                  ),
                ),
                  ],
                ),
              )
            ],
          ),
          backLayer: Stack(
            children: <Widget>[
              Container(
                width: _width,
                height: _height * 0.24,
                
              ),
              Container(
                  width: _width,
                  height: _height * 0.24,
                  child: Column(
                    children: <Widget>[
                      
                      Container(
                        padding: EdgeInsets.only(
                            left: _height * 0.04,
                            right: _height * 0.02,
                            top: _height * 0.01,
                            bottom: _height * 0.01),
                        width: _width,
                        height: _height * 0.22,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _buildCirclrImageProfile(context),
                            _buildHeaderDataProfile(context)
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackdropAppBar(
    BuildContext context,
  ) {
    final double _height = MediaQuery.of(context).size.height;
    return BackdropAppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed:() => func.logOut(context),
        
        )],
      backgroundColor:backgroundMainColor,
      centerTitle: true,
      title: Text(
        'Corporate Mobile Banking',
        style: TextStyle(fontSize: _height * 0.03),
      ),
    );
  }

  Widget _buildCirclrImageProfile(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      height: _height,
      width: _width * 0.25,
      child: CircleAvatar(
        radius: _height * 0.05,
        backgroundImage: AssetImage('assests/images/avatar-circle.png'),
      ),
    );
  }

  Widget _buildHeaderDataProfile(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(left: _height * 0.01),
        alignment: Alignment.centerLeft,
        height: _height,
        width: _width * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: _height * 0.01,
            ),
            Text(
              'คุณ' + globals.staffFname+ ' ' + globals.staffLname,
              style: TextStyle(fontSize: _height * 0.023, color: Colors.white),
            ),
            Text(
              'อีเมลล์: ' + globals.staffEmail,
              style: TextStyle(fontSize: _height * 0.023, color: Colors.white),
            ),
            Text(
              'เบอร์โทรศัพท์: ' + globals.staffMobile,
              style: TextStyle(fontSize: _height * 0.023, color: Colors.white),
            ),
            Text(
              'สถานะ: ' + globals.staffThem,
              style: TextStyle(fontSize: _height * 0.023, color: Colors.white),
            ),
            Text(
              'วันเวลาที่ใช้งานล่าสุด: ' + '',
              style: TextStyle(fontSize: _height * 0.023, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context, String menuName) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        checkNavigator(context, menuName);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color:backgroundMainColor,
        child: Container(
          alignment: Alignment.center,
          width: _width * 0.25,
          height: _height * 0.11,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _height * 0.02,
              ),
              checkIcon(context, menuName),
              Text(
                menuName,
                style: TextStyle(fontSize: _height * 0.02,color: Colors.white,)
              )
            ],
          ),
        ),
      ),
    );
  }

  checkIcon(BuildContext context, String menuName) {
    final double _height = MediaQuery.of(context).size.height;
    switch (menuName) {
      case "รายการรออนุมัติ":
        return Icon(
          Icons.assignment,
          color: Colors.white,
          size: _height * 0.05,
        );
        break;
      case "ประวัติการอนุมัติ":
        return Icon(
          Icons.history,
          color: Colors.white,
          size: _height * 0.05,
        );
        break;
      case "การตั้งค่า":
        return Icon(
          Icons.settings,
          color: Colors.white,
          size: _height * 0.05,
        );
        break;

      default:
    }
  }

  checkNavigator(BuildContext context, String menuName) {
   
    switch (menuName) {
      case "รายการรออนุมัติ":
        return Navigator.pushNamed(context, PageTo.authorizerApproveOrderScreen);
        break;
      case "ประวัติการอนุมัติ":
        return Navigator.pushNamed(context, PageTo.authorizerHistoryScreen);
        break;
      case "การตั้งค่า":
        return Navigator.pushNamed(context, PageTo.authorizerSettingScreen);
        break;

      default:
    }
  }

  

  
}
