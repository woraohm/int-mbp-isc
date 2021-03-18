import 'dart:convert';

import 'package:corperate_banking/global/global.dart' as globals;
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_transfer/transfer_single1_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rest_package/bean/accounts_request.dart';
import 'package:rest_package/bean/accounts_response.dart';
import 'package:rest_package/bean/accounts_show_response.dart';
import 'package:rest_package/connection/accounts_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/model/accounts_model.dart';

class TransferSingle extends StatefulWidget {
  @override
  _TransferSingleState createState() => _TransferSingleState();
}

class _TransferSingleState extends State<TransferSingle> {
  XSignature randReqRefNo = XSignature();
  AccountsConnection acctConnect = AccountsConnection(globals.iPV4, '8080');

  final formatMoney = new NumberFormat("#,##0.00", "en_US");
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

  Future<List<AccountsShowData>> getAllAccountsTransfSelect() async {
    List<AccountsResponse> dataAcctSaving = [];
    List<AccountsResponse> dataAcctCurrent = [];
    List<AccountsResponse> dataAcctFixed = [];
    List<AccountsShowData> allAcctList = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    print('reqRefNoAcct: ' + reqRefNo);
    AccountsRequest request = AccountsRequest(reqRefNo: reqRefNo);

    await acctConnect.connectAccounts(request, globals.token).then((value) {
      //print('status code getAccts= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        AccountsShowResponse response =
            AccountsShowResponse.fromJson(responseMap);
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(PageTo.indexScreen));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Color(0xFF3b074b),
          centerTitle: true,
          title: Text(
            'โอนเงิน',
            style: TextStyle(fontSize: _height * 0.03),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: _width,
              height: _height,
              
            ),
            Container(
              height: _height,
              width: _width,
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //         begin: Alignment.center,
              //         end: Alignment.bottomCenter,
              //         colors: [Colors.white, Colors.red])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: _height * 0.02, left: _height * 0.02),
                    child: Text('โอนเงินจาก',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: _height * 0.023,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: _height * 0.15,
                        width: _width,
                        decoration: BoxDecoration(
                            color: Color(0xFFF4F0F9),
                            borderRadius: BorderRadius.circular(40)),
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: _height * 0.05,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: _height * 0.02),
                            child: Text(
                              'กรุณาเลือกบัญชีต้นทาง',
                              style: TextStyle(
                                  fontSize: _height * 0.023,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            height: _height * 0.7,
                            width: _width,
                            color: Color(0xFFF4F0F9),
                            padding: EdgeInsets.only(
                                left: _height * 0.02, right: _height * 0.02),
                            child: FutureBuilder<List<AccountsShowData>>(
                              future: getAllAccountsTransfSelect(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  var acct = snapshot.data;
                                  return ListView.builder(
                                    itemCount: acct.length,
                                    itemBuilder: (context, int index) {
                                      return Card(
                                        elevation: 5,
                                        child: ExpansionTile(
                                          title: Text(
                                            acct[index].acctType,
                                            style: TextStyle(
                                                fontSize: _height * 0.02),
                                          ),
                                          children: <Widget>[
                                            Column(
                                              children: _buildExpandableContent(
                                                  context, acct[index]),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          )
                        ],
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

  _buildExpandableContent(BuildContext context, AccountsShowData acct) {
    final double _height = MediaQuery.of(context).size.height;
    List<Widget> columnContent = [];

    for (AccountsResponse content in acct.acctData)
      columnContent.add(
        Column(
          children: <Widget>[
            InkWell(
              onTap: () {
             
                print('ต้องการโอนเงิน: จาก');
                print('ชื่อบัญชี: '+ content.accName);
                print('ประเภทบัญชี: ' + acct.acctType);
                print('หมายเลขบัญชี: ' + content.acctNo);
                print('จากธนาคาร: ' + content.bankName);
                print('จำนวนเงินที่สามารถใช้งานได้: ' + content.availableBalance.toString());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransferSingle1(
                              fromAccountName: content.accName,
                              fromAccountType: acct.acctType,
                              fromAccountNumber: content.acctNo,
                              fromBankName: content.bankName==null?null:content.bankName,
                              fromAvailableBalnace: content.availableBalance,
                            )));
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: checkLogoBank(content.bankName),
                ),
                title: Text(
                  'หมายเลขบัญชี ' + content.acctNo,
                  style: TextStyle(fontSize: _height * 0.023),
                ),
                subtitle: Text(
                  'ยอดเงินที่สามารถใช้ได้ ' +
                      '${formatMoney.format(content.availableBalance)}' +
                      ' บาท',
                  style: TextStyle(fontSize: _height * 0.018),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF3b074b)),
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
