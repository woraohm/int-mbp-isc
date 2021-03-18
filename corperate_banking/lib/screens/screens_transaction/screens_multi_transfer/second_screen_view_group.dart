import 'dart:convert';
import 'dart:ffi';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/manage_group_recipient_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/third_screen_check_multi.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rest_package/bean/accounts_request.dart';
import 'package:rest_package/bean/accounts_response.dart';
import 'package:rest_package/bean/accounts_show_response.dart';
import 'package:rest_package/bean/inquily_info_transfer_group_request.dart';
import 'package:rest_package/bean/inquily_info_transfer_group_response.dart';
import 'package:rest_package/bean/manage_group_request.dart';
import 'package:rest_package/bean/manage_group_response.dart';
import 'package:rest_package/connection/accounts_connection.dart';
import 'package:rest_package/connection/inquily_info_transfer_group_connection.dart';
import 'package:rest_package/connection/manage_group_connection.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/model/inquily_info_transfer_group_model_request.dart';
import 'package:rest_package/model/inquily_info_transfer_group_model_response.dart';
import 'package:rest_package/model/manage_group_model_response.dart';

class ViewGroupScreen extends StatefulWidget {
  String groupName;

  ViewGroupScreen({this.groupName});

  @override
  _ViewGroupScreenState createState() =>
      _ViewGroupScreenState(groupName: groupName);
}

class _ViewGroupScreenState extends State<ViewGroupScreen> {
  String fromeAcctNo;
  String fromAcctName;
  String fromBankName;
  String groupName;
  String fromAcctNo = 'เลือกบัญชีต้นทาง';
  double availableBalance = 0.0;
  double totalAmount=0;
  
  
 
  
  

  _ViewGroupScreenState({this.groupName});
  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  FunctionGlobal func = FunctionGlobal();
  XSignature randReqRefNo = XSignature();
  ManageGroupConnection manageGroupConnection =
      ManageGroupConnection(globals.iPV4, '8080');
  AccountsConnection acctConnect = AccountsConnection(globals.iPV4, '8080');
  InquilyInfoTransferGroupConnection inquilyGroupConnect = InquilyInfoTransferGroupConnection(globals.iPV4, '8080');

  // List<DropdownMenuItem<AccountsResponse>> _dropdownMenuItem;

  Future<List<AccountsResponse>> getAllAccounts() async {
    List<AccountsResponse> res = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoAcct: ' + reqRefNo);
    AccountsRequest request = AccountsRequest(reqRefNo: reqRefNo);

    await acctConnect.connectAccounts(request, globals.token).then((value) {
      //print('status code getAcctsToDropDown= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);

        AccountsShowResponse response =
            AccountsShowResponse.fromJson(responseMap);
        print('response getAcctsToDropDown: ' + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (var data in response.accounts) {
            res.add(data);
          }
        }
      }
    });

    return res;
  }

  Future<List<ManageGroupModelResponse>> getMemberList(String groupName) async {
    List<ManageGroupModelResponse> res = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNogetMemberList: ' + reqRefNo);
    ManageGroupRequest request =
        ManageGroupRequest(reqRefNo: reqRefNo, groupName: groupName);
    await manageGroupConnection
        .connectManageGroup(request, globals.token)
        .then((value) {
      //print('status code getMemberList= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        ManageGroupResponse response =
            ManageGroupResponse.fromJson(responseMap);
        print("respDescgetMemberList: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          if (response.message == null) {
            for (ManageGroupModelResponse data in response.listManageGroup) {
              res.add(data);
            
            }
          } else {
            res.length = 0;
          }
        }
      }
    });

    return res;
  }
  Future<double> getTotalAmount(String groupName) async {
    double totalAmount=0;
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNogetTotalAmount: ' + reqRefNo);
    ManageGroupRequest request =
        ManageGroupRequest(reqRefNo: reqRefNo, groupName: groupName);
    await manageGroupConnection
        .connectManageGroup(request, globals.token)
        .then((value) {
      //print('status code getTotalAmount= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        ManageGroupResponse response =
            ManageGroupResponse.fromJson(responseMap);
        print("respDescgetTotalAmount: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          if (response.message == null) {
            for (ManageGroupModelResponse data in response.listManageGroup) {
              totalAmount+=data.amount;
            
            }
          } 
        }
      }
    });
    return totalAmount;
        
  }
  
  
  
  
  
  Future<void> checkButton() async{
    List<InquilyInfoTransferGroupModelRequest>listRequest=[];
    List<ManageGroupModelResponse> getListRequest=await getMemberList(this.groupName);
    List<InquilyInfoTransferGroupModelResponse>listResponse=[];
    for(var data in getListRequest){
      listRequest.add(
        InquilyInfoTransferGroupModelRequest(
          bank_Name_Recipient: data.bankName,
          recipient_account_No: data.trfAcctNo,
          recipient_account_No_name_Th: data.trfAcctNameTh,
          recipient_account_No_name_En: data.trfAcctNameEn,
          bank_Name_Sender: this.fromBankName,
          sender_Account_No: this.fromAcctNo,
          sender_Account_No_name_En: "",
          sender_Account_No_name_Th: this.fromAcctName,
          transAmount: data.amount
        )
      );
    }
    
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoCheckButton: ' + reqRefNo);
    InquilyInfoTransferGroupRequest request =
        InquilyInfoTransferGroupRequest(reqRefNo: reqRefNo, listRequest: listRequest);
    await inquilyGroupConnect.connectInquilyInfoTransferGroup(request, globals.token)
        .then((value) {
      //print('status code CheckButton= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        InquilyInfoTransferGroupResponse response =
            InquilyInfoTransferGroupResponse.fromJson(responseMap);
        print("respDescCheckButton: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
              listResponse=response.listResponse;
              print("responseSizeaaaaaaaaa     "+response.listResponse.length.toString());
              Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CheckMultiTransferScreen(
                      groupName: groupName,
                      fromAcctNo: this.fromAcctNo,
                      fromBankName: this.fromBankName,
                      fromAcctName: this.fromAcctName,
                      listResponse: listResponse,
                   
                    )));

              
          
        }else{
          print('Check Failed');
        }
      }
    });


 

 

    
 
  }

  @override
  void initState() {
    super.initState();
  }
 
  
  


  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: _buildAppBar(context, 'โอนหลายรายการ'),
        body: Container(
          width: _width,
          height: _height,
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: _height * 0.01, bottom: _height * 0.01),
                    alignment: Alignment.center,
                    color: Colors.white,
                    width: _width,
                    child: Text(
                      groupName,
                      style: TextStyle(fontSize: _height * 0.025),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: _height * 0.02, right: _height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'จาก หมายเลขบัญชี',
                          style: TextStyle(
                              fontSize: _height * 0.024, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.01,
                  ),
                  FutureBuilder<List<AccountsResponse>>(
                    future: getAllAccounts(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        var data = snapshot.data;
                        
                        return _buildShowAccount(context, data);
                      }
                    },
                  ),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: _height * 0.02, right: _height * 0.02),
                    child: Text(
                      'ไปยังบัญชี',
                      style: TextStyle(
                          fontSize: _height * 0.024, color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  FutureBuilder<List<ManageGroupModelResponse>>(
                    future: getMemberList(groupName),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        var data = snapshot.data;
                        int lengthData = data.length;
                        return Container(
                          color: Colors.white,
                          height: _height * 0.4,
                          child: _buildListAccountGroup(context, data, lengthData),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  FutureBuilder<double>(
                    future: getTotalAmount(groupName),
                    builder: (context,snapshot){
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator(),);
                      }else{
                        var data = snapshot.data;
                        return _buildTotalAmount(context, data);
                      }
                    },
                    ),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  _buildCheckButon(context)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, String name) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return AppBar(
      centerTitle: true,
      title: Text(
        name,
        style: TextStyle(fontSize: _height * 0.03, color: Colors.white),
      ),
      leading: func.appBarPop(context),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ManageGroupRecipientScreen(
                          groupName: groupName,
                        ))).then(onGoBack);
          },
        )
      ],
    );
  }
  void refreshData() {
    getMemberList(groupName);
  }

  onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  Widget _buildSelectAccount(
      BuildContext context, List<AccountsResponse> data) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: backgroundColor,
            elevation: 5,
            title: Row(
              children: [
                IconButton(
                    icon:
                        Icon(Icons.arrow_back_ios, color: backgroundMainColor),
                    onPressed: () => Navigator.pop(context)),
                Text('เลือกบัญชีต้นทางที่ต้องการ',
                    style: TextStyle(
                      fontSize: _height * 0.03,
                      color: Colors.black,
                    )),
              ],
            ),
            content: Container(
              height: _height,
              width: _width,
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.centerLeft,
                      width: _width,
                      child: Container(
                          padding: EdgeInsets.only(
                              left: _height * 0.01, right: _height * 0.01),
                          color: backgroundMainColor,
                          child: Text(
                            'บัญชีออมทรัพย์',
                            style: TextStyle(
                                fontSize: _height * 0.03, color: Colors.white),
                          ))),
                  Container(
                    width: _width,
                    height: _height * 0.004,
                    color: backgroundMainColor,
                  ),
                  SizedBox(
                    height: _height * 0.01,
                  ),
                  for (var value in data)
                    if (value.accType == 'บัญชีออมทรัพย์')
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                this.fromAcctNo = value.acctNo;
                                this.availableBalance = value.availableBalance;
                                this.fromBankName=value.bankName;
                                this.fromAcctName=value.accName;
                                this.fromeAcctNo=value.acctNo;
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: _width,
                              height: _height * 0.12,
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    width: _width * 0.2,
                                    height: _height,
                                    child: CircleAvatar(
                                      radius: _height * 0.04,
                                      backgroundImage:
                                          func.checkLogoBank(value.bankName),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: _height * 0.01,
                                      ),
                                      Container(
                                        width: _width * 0.45,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('หมายเลขบัญชี',
                                                style: TextStyle(
                                                  fontSize: _height * 0.024,
                                                )),
                                            Text(value.acctNo,
                                                style: TextStyle(
                                                  fontSize: _height * 0.024,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: _width * 0.45,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('ยอดเงินที่สามารถใช้ได้',
                                                style: TextStyle(
                                                  fontSize: _height * 0.024,
                                                )),
                                            Text(
                                                '${formatMoney.format(value.availableBalance)}',
                                                style: TextStyle(
                                                  fontSize: _height * 0.024,
                                                  color: Colors.green,
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.01,
                          )
                        ],
                      ),
                  Container(
                      alignment: Alignment.centerLeft,
                      width: _width,
                      child: Container(
                          padding: EdgeInsets.only(
                              left: _height * 0.01, right: _height * 0.01),
                          color: backgroundMainColor,
                          child: Text(
                            'บัญชีกระแสรายวัน',
                            style: TextStyle(
                                fontSize: _height * 0.03, color: Colors.white),
                          ))),
                  Container(
                    width: _width,
                    height: _height * 0.004,
                    color: backgroundMainColor,
                  ),
                  for (var value in data)
                    if (value.accType == 'บัญชีกระแสรายวัน')
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                this.fromAcctNo = value.acctNo;
                                this.availableBalance = value.availableBalance;
                                this.fromBankName=value.bankName;
                                this.fromAcctName=value.accName;
                                this.fromeAcctNo=value.acctNo;
                                
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: _width,
                              height: _height * 0.12,
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    width: _width * 0.2,
                                    height: _height,
                                    child: CircleAvatar(
                                      radius: _height * 0.04,
                                      backgroundImage:
                                          func.checkLogoBank(value.bankName),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: _height * 0.01,
                                      ),
                                      Container(
                                        width: _width * 0.45,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('หมายเลขบัญชี',
                                                style: TextStyle(
                                                  fontSize: _height * 0.024,
                                                )),
                                            Text(value.acctNo,
                                                style: TextStyle(
                                                  fontSize: _height * 0.024,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: _width * 0.45,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('ยอดเงินที่สามารถใช้ได้',
                                                style: TextStyle(
                                                  fontSize: _height * 0.024,
                                                )),
                                            Text(
                                                '${formatMoney.format(value.availableBalance)}',
                                                style: TextStyle(
                                                  fontSize: _height * 0.024,
                                                  color: Colors.green,
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.01,
                          )
                        ],
                      ),
                  Container(
                      alignment: Alignment.centerLeft,
                      width: _width,
                      child: Container(
                          padding: EdgeInsets.only(
                              left: _height * 0.01, right: _height * 0.01),
                          color: backgroundMainColor,
                          child: Text(
                            'บัญชีเงินฝากประจำ',
                            style: TextStyle(
                                fontSize: _height * 0.03, color: Colors.white),
                          ))),
                  Container(
                    width: _width,
                    height: _height * 0.004,
                    color: backgroundMainColor,
                  ),
                  for (var value in data)
                    if (value.accType == 'บัญชีเงินฝากประจำ')
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                this.fromAcctNo = value.acctNo;
                                this.availableBalance = value.availableBalance;
                                this.fromBankName=value.bankName;
                                this.fromAcctName=value.accName;
                                this.fromeAcctNo=value.acctNo;
                                
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: _width,
                              height: _height * 0.12,
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    width: _width * 0.2,
                                    height: _height,
                                    child: CircleAvatar(
                                      radius: _height * 0.04,
                                      backgroundImage:
                                          func.checkLogoBank(value.bankName),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: _height * 0.01,
                                      ),
                                      Container(
                                        width: _width * 0.45,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('หมายเลขบัญชี',
                                                style: TextStyle(
                                                  fontSize: _height * 0.024,
                                                )),
                                            Text(value.acctNo,
                                                style: TextStyle(
                                                  fontSize: _height * 0.024,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: _width * 0.45,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('ยอดเงินที่สามารถใช้ได้',
                                                style: TextStyle(
                                                  fontSize: _height * 0.024,
                                                )),
                                            Text(
                                                '${formatMoney.format(value.availableBalance)}',
                                                style: TextStyle(
                                                  fontSize: _height * 0.024,
                                                  color: Colors.green,
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.01,
                          )
                        ],
                      )
                ],
              ),
            ),
          );
        });
    ;
  }

  Widget _buildShowAccount(BuildContext context, List<AccountsResponse> data) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        _buildSelectAccount(context, data);
      },
      child: Container(
        alignment: Alignment.center,
        child: Container(
          width: _width * 0.4,
          height: _height * 0.1,
          decoration:
              BoxDecoration(border: Border.all(color: backgroundMainColor)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: _height * 0.01, right: _height * 0.01),
                child: Text(
                  this.fromAcctNo,
                  style: TextStyle(fontSize: _height * 0.028),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: _height * 0.01, right: _height * 0.01),
                child: Text(
                  '${formatMoney.format(this.availableBalance)}',
                  style:
                      TextStyle(fontSize: _height * 0.028, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListAccountGroup(BuildContext context, List<ManageGroupModelResponse> data, int lengthData) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
          return lengthData != 0
              ? ListView.builder(
                  itemCount: lengthData,
                  itemBuilder: (context, int index) {
                    return Column(
                      children: [
                        ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  func.checkLogoBank(data[index].bankName),
                            ),
                            title: Text(
                               data[index].trfAcctNameTh!=null?
                              data[index].trfAcctNameTh: data[index].trfAcctNameEn,
                              style: TextStyle(fontSize: _height * 0.028),
                            ),
                            subtitle: Text(
                              'หมายเลขบัญชี ' + data[index].trfAcctNo,
                              style: TextStyle(
                                  fontSize: _height * 0.024,
                                  color: Colors.grey),
                            ),
                            trailing: Text(
                              '${formatMoney.format(data[index].amount)}',
                              style: TextStyle(
                                  fontSize: _height * 0.028,
                                  color: Colors.green),
                            )),
                        SizedBox(
                          child: Container(
                            width: _width,
                            height: _height * 0.001,
                            color: Colors.grey[200],
                          ),
                        )
                      ],
                    );
                  },
                )
                
              : Center(
                  child: Text(
                    'ไม่มีผู้รับเงิน',
                    style: TextStyle(fontSize: _height * 0.026),
                  ),
                );
        
      
    
  }

  Widget _buildTotalAmount(BuildContext context, double data) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
      width: _width,
      height: _height * 0.09,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'จำนวนเงินทั้งหมด',
            style: TextStyle(fontSize: _height * 0.028),
          ),
          Text(
            '${formatMoney.format(data)}',
            style: TextStyle(fontSize: _height * 0.028),
          )
        ],
      ),
    );
  }

  Widget _buildCheckButon(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return this.availableBalance!=0?
    Padding(
      padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
      child: InkWell(
        onTap: () => checkButton(),
        child: Container(
          width: _width,
          height: _height * 0.08,
          color: backgroundMainColor,
          alignment: Alignment.center,
          child: Text(
            'ตรวจสอบข้อมูล',
            style: TextStyle(fontSize: _height * 0.03, color: Colors.white),
          ),
        ),
      ),
    ):
    Padding(
      padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
      child: InkWell(
        child: Container(
          width: _width,
          height: _height * 0.08,
          color: Colors.grey,
          alignment: Alignment.center,
          child: Text(
            'ตรวจสอบข้อมูล',
            style: TextStyle(fontSize: _height * 0.03, color: Colors.white),
          ),
        ),
      ),
    );

  }
}
