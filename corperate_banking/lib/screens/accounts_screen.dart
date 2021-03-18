import 'dart:convert';

import 'package:corperate_banking/global_function.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/bean/ostdTotal_response.dart';
import 'package:rest_package/connection/graph_connection.dart';
import 'package:rest_package/bean/graph_request.dart';
import 'package:rest_package/bean/graph_show_response.dart';
import 'package:rest_package/bean/accounts_request.dart';
import 'package:rest_package/bean/accounts_response.dart';
import 'package:rest_package/bean/accounts_show_response.dart';
import 'package:rest_package/connection/accounts_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/model/accounts_model.dart';
import 'package:rest_package/bean/graph_response.dart';
import 'package:rest_package/connection/ostdTotal_connection.dart';
import 'package:rest_package/bean/ostdTotal_request.dart';

class AccountsScreen extends StatefulWidget {
  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  FunctionGlobal func = FunctionGlobal();
  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  AccountsConnection acctConnect = AccountsConnection(globals.iPV4, '8080');
  GraphConnection graphConnect = GraphConnection(globals.iPV4, '8080');
  OSTDTotalConnection ostdTotalConnect =
      OSTDTotalConnection(globals.iPV4, '8080');
  XSignature randReqRefNo = XSignature();
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

      default:
        return AssetImage('assests/images/avatar-circle.png');
    }
  }

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
      print('status code getOSTDTotal= ' + value.statusCode.toString());
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

  Future<List<AccountsShowData>> getAllAccounts() async {
    List<AccountsResponse> dataAcctSaving = [];
    List<AccountsResponse> dataAcctCurrent = [];
    List<AccountsResponse> dataAcctFixed = [];
    List<AccountsShowData> allAcctList = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoAcct: ' + reqRefNo);
    AccountsRequest request = AccountsRequest(reqRefNo: reqRefNo);

    await acctConnect.connectAccounts(request, globals.token).then((value) {
      //print('status code getAccts= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);

        AccountsShowResponse response =
            AccountsShowResponse.fromJson(responseMap);
        print('response getAllAcct: '+response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (AccountsResponse data in response.accounts) {
            if (data.accType == 'บัญชีออมทรัพย์') {
              dataAcctSaving.add(data);
              // print('add '+data.acctNo+' success');
            }
            if (data.accType == 'บัญชีกระแสรายวัน') {
              dataAcctCurrent.add(data);
              // print('add '+data.acctNo+' success');
            }
            if (data.accType == 'บัญชีเงินฝากประจำ') {
              dataAcctFixed.add(data);
              //print('add '+data.acctNo+' success');
            }
          }
          // print('dataAcctSaving length: '+dataAcctSaving.length.toString());
          // print('dataAcctCurrent length: '+dataAcctCurrent.length.toString());
          // print('dataAcctFixed length: '+dataAcctFixed.length.toString());
          allAcctList.add(
            AccountsShowData(
                acctType: 'บัญชีออมทรัพย์', acctData: dataAcctSaving),
          );
          allAcctList.add(
            AccountsShowData(
                acctType: 'บัญชีกระแสรายวัน', acctData: dataAcctCurrent),
          );
          allAcctList.add(AccountsShowData(
              acctType: 'บัญชีเงินฝากประจำ', acctData: dataAcctFixed));
          // print('allAcctList length: '+allAcctList.length.toString());
        }
      }
    });
    return allAcctList;
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: ()=>func.onBackPressed(context),
          child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   leading: Container(),
          //   backgroundColor: Color(0xFF3b074b),
          //   centerTitle: true,
          //   title: Text(
          //     'Coporate Mobile Banking',
          //     style: TextStyle(fontSize: _height * 0.03),
          //   ),
          // ),
          body: Container(
            height: _height,
            width: _width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [Colors.black, Color(0xFF3b074b)])),
            child: Stack(
              children: <Widget>[
                Container(
                  
                  height: _height,
                  width: _width,
                  // color: Color(0xFFE4E1F4),
                  // child: Image.asset(
                  //   'assests/images/pink-geometric.jpg',
                  //   fit: BoxFit.cover,
                  // ),
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: _height * 0.02,
                        right: _height * 0.02,
                        // top: _height * 0.01,
                        // bottom: _height * 0.01,
                      ),
                      height: _height * 0.1,
                      width: _width,
                      child: FutureBuilder<double>(
                        future: getOSTDTotal(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            var ostdTotal = snapshot.data;
                            return ListTile(
                              title: Text(
                                'ยอดรวมสินทรัพย์',
                                style: TextStyle(
                                    fontSize: _height * 0.032,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              subtitle: Text(
                                '${formatMoney.format(ostdTotal)}' + ' บาท',
                                style: TextStyle(
                                    fontSize: _height * 0.026,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            );
                          }
                        },
                      ),
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
                                    fontSize: _height * 0.023,
                                    color: Colors.white),
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
                    Stack(
                      children: <Widget>[
                        // Container(
                        //   height: _height * 0.1,
                        //   width: _width,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(45),
                        //     color: Color(0xFFF4F0F9),
                        //   ),
                        // ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: _height * 0.04,
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              height: _height * 0.4,
                              width: _width,
                              padding: EdgeInsets.only(
                                left: _height * 0.02,
                                right: _height * 0.02,
                                // top: _height * 0.01,
                                // bottom: _height * 0.01,
                              ),
                              
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: _height * 0.35),
                  width: _width,
                  height: _height,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: _height * 0.02,
                        right: _height * 0.02,
                        top: _height * 0.02),
                    width: _width,
                    height: _height,
                    color: Color(0xFFeaecf0),
                    child: FutureBuilder<List<AccountsShowData>>(
                      future: getAllAccounts(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var acct = snapshot.data;

                          return ListView.builder(
                            itemCount: acct.length,
                            itemBuilder: (context, int i) {
                              return Card(
                                elevation: 5,
                                child: ExpansionTile(
                                  title: Text(
                                    acct[i].acctType,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: _height * 0.028,
                                        color: Color(0xFF2a2a39)),
                                  ),
                                  children: <Widget>[
                                    Column(
                                        children: _buildExpandableContent(
                                            context, acct[i])),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildExpandableContent(BuildContext context, AccountsShowData account) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    List<Widget> columnContent = [];

    for (AccountsResponse content in account.acctData)
      columnContent.add(
        Column(
          children: <Widget>[
            Container(
              width: _width,
              height: _height * 0.15,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: _width * 0.16,
                    height: _height,
                    child: CircleAvatar(
                      radius: _height * 0.04,
                      backgroundImage: checkLogoBank(content.bankName),
                    ),
                  ),
                  Container(
                    width: _width * 0.73,
                    height: _height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: _height * 0.01, top: _height * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'หมายเลขบัญชี ',
                                style: TextStyle(
                                    fontSize: _height * 0.026,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2a2a39)),
                              ),
                              Text(
                                content.acctNo,
                                style: TextStyle(
                                    fontSize: _height * 0.026,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2a2a39)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: _height * 0.01, top: _height * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'ยอดเงินที่สามารถใช้ได้ ',
                                style: TextStyle(
                                    fontSize: _height * 0.026,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2a2a39)),
                              ),
                              Text(
                                '${formatMoney.format(content.availableBalance)}',
                                style: TextStyle(
                                    fontSize: _height * 0.030,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: _height * 0.01, top: _height * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'ยอดเงินคงเหลือในบัญชี ',
                                style: TextStyle(
                                    fontSize: _height * 0.026,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2a2a39)),
                              ),
                              Text(
                                '${formatMoney.format(content.ostdBalance)}',
                                style: TextStyle(
                                    fontSize: _height * 0.030,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            
            SizedBox(
              height: _height * 0.00095,
              child: Container(
                color: Colors.grey,
              ),
            )
          ],
        ),
      );
    return columnContent;
  }
}
