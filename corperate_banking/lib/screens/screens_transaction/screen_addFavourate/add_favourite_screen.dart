import 'dart:convert';
import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:rest_package/bean/add_favourite_acct_request.dart';
import 'package:rest_package/bean/add_favourite_acct_response.dart';
import 'package:rest_package/bean/get_acct_to_add_favourite_request.dart';
import 'package:rest_package/bean/get_acct_to_add_favourite_response.dart';
import 'package:rest_package/connection/add_favourite_acct_connection.dart';

import 'package:rest_package/connection/company_user_acct_connection.dart';
import 'package:rest_package/connection/get_acct_to_add_favourite_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';

import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/model/get_acct_to_add_favourite_model_response.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddFavouriteScreen extends StatefulWidget {
  @override
  _AddFavouriteScreenState createState() => _AddFavouriteScreenState();
}

class _AddFavouriteScreenState extends State<AddFavouriteScreen> {
  FunctionGlobal func = FunctionGlobal();
  CompanyUserAcctConnection companyUserAcctConnect =
      CompanyUserAcctConnection(globals.iPV4, '8080');
  GetAcctToAddFavouriteConnection getAcctToAddFavConnect =
      GetAcctToAddFavouriteConnection(globals.iPV4, '8080');
  AddFavouriteAcctConnection addFavConnect =
      AddFavouriteAcctConnection(globals.iPV4, '8080');
  XSignature randReqRefNo = XSignature();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  String acctName = "";
  String bankName ="";
  String acctNumber = "";

  
  

  Future<void> addFavAcct() async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoAddFavAcct: ' + reqRefNo);
    AddFavouriteAcctRequest request = AddFavouriteAcctRequest(
        reqRefNo: reqRefNo,
        acctName: acctName,
        acctNo: acctNumber,
        bankName: bankName
        );
    await addFavConnect
        .connectAddFavouriteAcct(request, globals.token)
        .then((value) {
      //print('status code AddFavAcct= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        AddFavouriteAcctResponse response =
            AddFavouriteAcctResponse.fromJson(responseMap);
        print("respDescAddFavAcct: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          print('add favorite account success');
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "เพิ่มบัญชีโปรดสำเร็จ",
              textStyle: TextStyle(fontSize: 20),
            ),
          );
          Navigator.of(context)
              .popUntil(ModalRoute.withName(PageTo.indexScreen));
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      getAcctToAddFav();
    });

    return null;
  }

  Future<List<GetAcctToAddFavouriteModelResponse>> getAcctToAddFav() async {
    List<GetAcctToAddFavouriteModelResponse> getAcctToAddFavList = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetAcctToAddFav: ' + reqRefNo);
    GetAcctToAddFavouriteRequest request =
        GetAcctToAddFavouriteRequest(reqRefNo: reqRefNo);
    await getAcctToAddFavConnect
        .connectGetAcctToAddFavourite(request, globals.token)
        .then((value) {
      //print('status code GetAcctToAddFav= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        GetAcctToAddFavouriteResponse response =
            GetAcctToAddFavouriteResponse.fromJson(responseMap);
        print("respDescGetAcctToAddFav: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (GetAcctToAddFavouriteModelResponse dataCompany in response.listAcctCompany) {
            getAcctToAddFavList.add(dataCompany);
          }
          for(GetAcctToAddFavouriteModelResponse dataOther in response.listAcctOther){
            
             getAcctToAddFavList.add(dataOther);
          }
          
        }
      }
    });
  
    return getAcctToAddFavList;
  }

  addFavouritConfirm(BuildContext context, double _height, double _width) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Padding(
              padding:
                  EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
              child: Container(
                alignment: Alignment.center,
                height: _height * 0.23,
                width: _width,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('การยืนยันการเพิ่มบัญชีโปรด',
                          style: TextStyle(fontSize: _height * 0.02)),
                    ),
                    Divider(),
                    ListTile(
                      leading: CircleAvatar(
                        radius: _height * 0.03,
                        backgroundImage:
                            func.checkLogoBank(this.bankName),
                      ),
                      title: Text(
                        'คุณ' + acctName,
                        style: TextStyle(fontSize: _height * 0.02),
                      ),
                      subtitle: Text(
                        'หมายเลขบัญชี' + ' ' + acctNumber,
                        style: TextStyle(fontSize: _height * 0.02),
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: _width * 0.5,
                        height: _height * 0.05,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFCFCFCF),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Text(
                                    'ยกเลิก',
                                    style: TextStyle(
                                        fontSize: _height * 0.02,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: _height * 0.01,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                 
                                  addFavAcct();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF3b074b),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Text(
                                    'ตกลง',
                                    style: TextStyle(
                                        fontSize: _height * 0.02,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
      
        appBar: _buildAppbar(context, _height),
        body: Stack(
          children: [
            Container(
              height: _height,
              width: _width,
              color: Color(0xFFeaecf0),
            ),
            Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.white]),
            )),
            Container(
              height: _height,
              width: _width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: _height * 0.02, right: _height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'กรุณาเลือกบัญชีที่ต้องการ',
                          style: TextStyle(
                              fontSize: _height * 0.023,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.search,
                          size: _height * 0.03,
                          color: Color(0xFF3b074b),
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: _height * 0.01,
                  // ),
                  
                  Stack(
                    children: <Widget>[
                      Container(
                        height: _height * 0.12,
                        width: _width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40)),
                      ),
                      Column(
                        
                        children: <Widget>[
                          SizedBox(
                            height: _height * 0.04,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: _height * 0.02, right: _height * 0.02),
                            height: _height * 0.8,
                            width: _width,
                            color: Colors.white,
                            child: _buildSelectAccountFavourite(
                                context),
                          )
                        ],
                      )
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

  Widget _buildAppbar(BuildContext context, double _height) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      backgroundColor: Color(0xFF3b074b),
      centerTitle: true,
      title: Text(
        'เพิ่มบัญชีโปรด',
        style: TextStyle(fontSize: _height * 0.03),
      ),
    );
  }

  Widget _buildSelectAccountFavourite(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: refreshList,
      child: FutureBuilder<List<GetAcctToAddFavouriteModelResponse>>(
        future: getAcctToAddFav(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, int index) {
                return Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        print('ต้องการเพิ่มบัญชีโปรด:');
                        print('acctName: ' + data[index].acctName);
                        print('bankName: '+data[index].bankName);
                        print('acctNumber: ' + data[index].acctNo);

                        acctName = data[index].acctName;
                        bankName= data[index].bankName;
                        acctNumber = data[index].acctNo;
                        addFavouritConfirm(context, _height, _width);
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: func.checkLogoBank(data[index].bankName),
                              
                     
                        ),
                        title: Text(
                           data[index].acctName,
                             
                          style: TextStyle(fontSize: _height * 0.026),
                        ),
                        subtitle: Text('หมายเลขบัญชี ' + data[index].acctNo,
                            style: TextStyle(fontSize: _height * 0.023)),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF3b074b),
                          size: _height * 0.02,
                        ),
                      ),
                    ),
                    Divider(),
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
