import 'dart:convert';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/screens/statement/generate_pdf.dart';
import 'package:corperate_banking/screens/statement/source_statement.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets/multi_page.dart';
import 'package:rest_package/bean/accounts_request.dart';
import 'package:rest_package/bean/accounts_response.dart';
import 'package:rest_package/bean/accounts_show_response.dart';
import 'package:rest_package/bean/statement_request.dart';
import 'package:rest_package/bean/statement_response.dart';
import 'package:rest_package/connection/accounts_connection.dart';
import 'package:rest_package/connection/statement_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/model/statement_discription_list_model_response.dart';
import 'package:rest_package/model/statement_list_model_response.dart';

class StatementScreen extends StatefulWidget {
  @override
  _StatementScreenState createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  AccountsConnection acctConnect = AccountsConnection(globals.iPV4, '8080');
  StatementConnection statementConnect = StatementConnection(globals.iPV4, '8080');
  XSignature randReqRefNo = XSignature();
  FunctionGlobal func = FunctionGlobal();
  DateTime selectedDateForm = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  String selectAccount = 'เลือกบัญชี';
  bool hasData=false;

  List<StatementListModelResponse>statementList=[];
  List<StatementDescriptionListModelResponse>statementDescriptionList=[];

  String manageDate(var str){
    List<String> output=[];
    output=str.split(' ');
    //print(output);

    return output[0];
  }
  String manageTime(var str){
    List<String> output=[];
    output=str.split(' ');
    output=output[1].split('.');
    //print(output);

    return output[0];
  }
  //GeneratePDF
  List<dynamic> _generateTableData() {
    int lengthStatementList=statementList.length;
 
    String str="";
    for(int o=0;o<lengthStatementList;o++){
    
      return [{
      'no':o+1,
      'date':manageDate(statementList[o].dateTime),
      'time':manageTime(statementList[o].dateTime),
      'tracNo':statementList[o].traceNo,
      'ostdBalance':statementList[o].ledgerBalAmt.toString(),
      'description':statementList[o].description.toString()+" จาก "+statementList[o].frAcctNo.toString()+" ถึง "+statementList[o].destAcctNo.toString()

      }];
    }
    return null;
  }

  _generatePDFData() {
    List<List<String>> data = [];
    for (dynamic d in _generateTableData())
      data.add(<String>[
        d['no'].toString(),
        d['date'],
        d['time'],
        d['tracNo'],
        d['ostdBalance'],
        d['description']
      ]);
    return data;
  }

  Future<Null> _selectDateForm(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateForm,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateForm)
      setState(() {
        print('วันเริ่มต้นที่เลือก: ' + picked.toLocal().toString());
        selectedDateForm = picked;
      });
  }

  Future<Null> _selectDateTo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTo,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateTo)
      setState(() {
        print('วันสุดท้ายที่เลือก: ' + picked.toLocal().toString());
        selectedDateTo = picked;
      });
  }

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

  Future<void> getStatement()async{
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNogetStatement: ' + reqRefNo);
    String uSelectFormDate = selectedDateForm.year.toString()+"-"+selectedDateForm.month.toString()+"-"+selectedDateForm.day.toString();
    String uSelectTodate = selectedDateTo.year.toString()+"-"+selectedDateTo.month.toString()+"-"+selectedDateTo.day.toString();
    String uSelectAccount= selectAccount=="เลือกทั้งหมด"?null:selectAccount;
    StatementRequest request =
        StatementRequest(reqRefNo: reqRefNo,dateStart: uSelectFormDate,dateEnd: uSelectTodate,acctNo: uSelectAccount);
    await statementConnect
        .statementConnection(request, globals.token)
        .then((value) {
      //print('status code getStatement= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        StatementResponse response =
            StatementResponse.fromJson(responseMap);
        print("respDescgetStatement: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
              if(response.statementList.length!=0){
                setState(() {
                  this.hasData=true;
                });
                
              for(StatementListModelResponse data in response.statementList){
                statementList.add(data);
              }
              globals.selectDateTime=response.descriptionStatementList[0].period;
              
              }else{
                func.showAlert(context, 'ไม่มีข้อมูล');
                setState(() {
                  this.hasData=false;
                });
                
              }
              


          
          
        }
      }
    });
  }
  @override
  void initState(){
    this.hasData=false;
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: _buildAppBar(context, _height),
          backgroundColor: Color(0xFFeaecf0),
          body: Container(
            width: _width,
            height: _height,
            child: ListView(
              children: <Widget>[
                Container(
                  width: _width,
                  height: _height * 0.33,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Color(0xFF3b074b)])),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: _height * 0.06,
                        right: _height * 0.06,
                        top: _height * 0.03),
                    child: Column(
                      children: <Widget>[
                        _buildformDate(context),
                        SizedBox(
                          height: _height * 0.01,
                        ),
                        _buildToDate(context),
                        SizedBox(
                          height: _height * 0.01,
                        ),
                        _buildSelectAccount(context),
                        SizedBox(
                          height: _height * 0.01,
                        ),
                        _buildButtonSent(context),
                        SizedBox(
                          height: _height * 0.01,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.02,
                ),
                // Container(
                //   padding: EdgeInsets.only(
                //       left: _height * 0.02, right: _height * 0.02),
                //   width: _width,
                //   child: makeBody(context,statementList,statementDescriptionList),
                // ),
                SizedBox(
                  height: _height * 0.02,
                ),
                this.hasData==true? 
                Padding(
                  padding: EdgeInsets.only(
                      left: _height * 0.02, right: _height * 0.02),
                  child: 
                  InkWell(
                      onTap: () {

                        print(statementList.length);
                        var columns = [
                          "no",
                          "date",
                          "time",
                          "tracNo",
                          "ostdBalace",
                          "description"
                        ];
                        generatePDF(columns, _generatePDFData()).then((value) {
                          if (value)
                            showSuccessToast();
                          else
                            showErrorToast();
                        });
                      },
                      child: Card(
                        elevation: 5,
                        color: backgroundMainColor,
                        child: Container(
                          alignment: Alignment.center,
                          color: backgroundMainColor,
                          width: _width,
                          height: _height * 0.07,
                          child: Text(
                            "ดาวน์โหลดรายการเดินบัญชี",
                            style: TextStyle(
                                color: Colors.white, fontSize: _height * 0.03),
                          ),
                        ),
                      )
                      )
                      
                ):Container()

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
        backgroundColor: Color(0xFF3b074b),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'รายการเดินบัญชี',
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }

  Widget _buildformDate(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('เลือกวันเริ่มต้น',
            style: TextStyle(
              fontSize: _height * 0.026,
              color: Colors.white,
            )),
        Row(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
              alignment: Alignment.center,
              width: _width * 0.4,
              height: _height * 0.05,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Text(
                "${selectedDateForm.toLocal()}".split(' ')[0],
                style:
                    TextStyle(fontSize: _height * 0.023, color: Colors.white),
              ),
            ),
            IconButton(
                onPressed: () {
                  _selectDateForm(context);
                },
                icon: Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                ))
          ],
        ),
      ],
    );
  }

  Widget _buildToDate(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('เลือกวันสุดท้าย',
            style: TextStyle(
              fontSize: _height * 0.026,
              color: Colors.white,
            )),
        Row(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
              alignment: Alignment.center,
              width: _width * 0.4,
              height: _height * 0.05,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Text(
                "${selectedDateTo.toLocal()}".split(' ')[0],
                style:
                    TextStyle(fontSize: _height * 0.023, color: Colors.white),
              ),
            ),
            IconButton(
                onPressed: () {
                  _selectDateTo(context);
                },
                icon: Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                ))
          ],
        ),
      ],
    );
  }

  Widget _buildButtonSent(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.centerRight,
      width: _width,
      height: _height * 0.06,
      child: InkWell(
        onTap: () {
          if(this.selectAccount=="เลือกบัญชี"){
            func.showAlert(context, "กรุณากรอกข้อมูล");
            print('กรุณากรอกข้อมูล');
          }else{
      
            this.selectAccount=='เลือกทั้งหมด'?
            globals.selectAccount='บัญชีทั้งหมด':globals.selectAccount=this.selectAccount;
            getStatement();

          }
          
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Container(
            alignment: Alignment.center,
            width: _width * 0.3,
            height: _height,
            child: Text(
              'ส่งข้อมูล',
              style: TextStyle(fontSize: _height * 0.023),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectAccount(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('เลือกบัญชีที่ต้องการ',
            style: TextStyle(
              fontSize: _height * 0.026,
              color: Colors.white,
            )),
        FutureBuilder<List<AccountsResponse>>(
          future: getAllAccounts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = snapshot.data;
              return Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: _height * 0.02, right: _height * 0.02),
                      alignment: Alignment.center,
                      width: _width * 0.4,
                      height: _height * 0.05,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Text(selectAccount,
                          style: TextStyle(
                            fontSize: _height * 0.026,
                            color: Colors.white,
                          ))),
                  IconButton(
                      onPressed: () {
                        _buildSelectAccounts(context, data);
                      },
                      icon: Icon(
                        Icons.quick_contacts_mail_rounded,
                        color: Colors.white,
                      ))
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildSelectAccounts(
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
                  InkWell(
                    onTap: () {
                      setState(() {
                        this.selectAccount = "เลือกทั้งหมด";
                      });
                      Navigator.pop(context);
                    },
                    child: Card(
                      elevation: 5,
                      color: Colors.red,
                      child: Container(
                        alignment: Alignment.center,
                        height: _height * 0.05,
                        width: _width,
                        child: Text(
                          'เลือกทั้งหมด',
                          style: TextStyle(
                              fontSize: _height * 0.026, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
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
                                this.selectAccount = value.acctNo;
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
                                this.selectAccount = value.acctNo;
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
                                this.selectAccount = value.acctNo;
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
}

class Model{
  int no;
  String date;
  String time;
  String tracNo;
  double ostdBalance;
  String description;

  Model({this.date,this.description,this.no,this.ostdBalance,this.time,this.tracNo});
}
