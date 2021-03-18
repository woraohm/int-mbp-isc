import 'dart:convert';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_transfer/check_transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:rest_package/bean/delete_favourite_acct_request.dart';
import 'package:rest_package/bean/delete_favourite_acct_response.dart';
import 'package:rest_package/bean/delete_other_acct_request.dart';
import 'package:rest_package/bean/delete_other_acct_response.dart';
import 'package:rest_package/bean/favourite_acct_request.dart';
import 'package:rest_package/bean/favourite_acct_response.dart';
import 'package:rest_package/bean/inquily_info_transfer_group_request.dart';
import 'package:rest_package/bean/inquily_info_transfer_group_response.dart';
import 'package:rest_package/bean/other_user_acct_request.dart';
import 'package:rest_package/bean/other_user_acct_response.dart';
import 'package:rest_package/connection/checkAccount_connection.dart';
import 'package:rest_package/connection/delete_favourite_acct_connection.dart';
import 'package:rest_package/connection/delete_other_acct_connection.dart';
import 'package:rest_package/connection/favourite_acct_connection.dart';
import 'package:rest_package/connection/inquily_info_transfer_group_connection.dart';
import 'package:rest_package/connection/other_user_acct_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/bean/company_user_acct_request.dart';
import 'package:rest_package/bean/company_user_acct_response.dart';
import 'package:rest_package/bean/company_user_acct_show_response.dart';
import 'package:rest_package/connection/company_user_acct_connection.dart';
import 'package:rest_package/model/favourite_acct_model_response.dart';
import 'package:rest_package/model/inquily_info_transfer_group_model_request.dart';
import 'package:rest_package/model/other_user_acct_model_response.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TransferSingle1 extends StatefulWidget {
  String fromAccountName;
  String fromAccountType;
  String fromAccountNumber;
  String fromBankName;
  double fromAvailableBalnace;

  TransferSingle1(
      {this.fromAccountName,
      this.fromAccountType,
      this.fromAccountNumber,
      this.fromBankName,
      this.fromAvailableBalnace});

  @override
  _TransferSingle1State createState() => _TransferSingle1State(
      fromAccountName: fromAccountName,
      fromAccountType: fromAccountType,
      fromAccountNumber: fromAccountNumber,
      fromBankName: fromBankName,
      fromAvailableBalnace: fromAvailableBalnace);
}

class _TransferSingle1State extends State<TransferSingle1>
    with SingleTickerProviderStateMixin {
  String fromAccountName;
  String fromAccountType;
  String fromAccountNumber;
  double fromAvailableBalnace;
  String fromBankName;
  _TransferSingle1State(
      {this.fromAccountName,
      this.fromAccountType,
      this.fromAccountNumber,
      this.fromBankName,
      this.fromAvailableBalnace});
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  XSignature randReqRefNo = XSignature();
  final _formKey = GlobalKey<FormState>();
  CheckHasAccountConnection checkAcctConnect =
      CheckHasAccountConnection(globals.iPV4, '8080');
  CompanyUserAcctConnection companyUserAcctConnect =
      CompanyUserAcctConnection(globals.iPV4, '8080');
  OtherUserAcctConnection otherAcctConnect =
      OtherUserAcctConnection(globals.iPV4, '8080');
  FavouriteAcctConnection favouriteAcctConnect =
      FavouriteAcctConnection(globals.iPV4, '8080');
  DeleteOtherAcctConnection deleteOtherAcctConnect =
      DeleteOtherAcctConnection(globals.iPV4, '8080');
  DeleteFavouriteAcctConnection deleteFavConnect =
      DeleteFavouriteAcctConnection(globals.iPV4, '8080');
  InquilyInfoTransferGroupConnection inquiltInfoConnect = InquilyInfoTransferGroupConnection(globals.iPV4, '8080');

  FunctionGlobal func = FunctionGlobal();
  TabController _controller;
  final amountController = TextEditingController();
  final amountView = MoneyMaskedTextController( decimalSeparator: '.', thousandSeparator: ',');
  TextEditingController noteController = TextEditingController();

  bool viewVisibleTransferInCompany = false;
  bool viewVisibleTransferOtherCompany = false;
  bool viewVisibleTransferPromtpay = false;
  String toBankName = "";
  String toAcctNumber = "";
  String toAcctName = "";
  String toLName = "";
  String transfType = "";
  String toAcctType = "";
  List<InquilyInfoTransferGroupModelRequest>listRequest=[];

  Future<Null> refreshListCompanyAccts() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      getCompanyUserAcct();
    });

    return null;
  }

  Future<Null> refreshListOtherUserAccts() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      getAllAccountOtherCompany();
    });

    return null;
  }

  Future<Null> refreshListFavouriteAcctUser() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      getFavaouriteAcct();
    });

    return null;
  }

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
        AssetImage('assests/images/avatar-circle.png');
    }
  }

  checkNameBank(String bankName) {
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
      case "ไม่มีธนาคาร":
        return "";
        break;

      default:
        return "null";
    }
  }

  Future<void> deleteFavouriteAcct(
      String acctNo, String acctName, String bankName) async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoDeleteFavouriteAcct: ' + reqRefNo);
    DeleteFavouriteAcctRequest request = DeleteFavouriteAcctRequest(
        acctName: acctName,
        acctNo: acctNo,
        bankName: bankName,
        reqRefNo: reqRefNo);
    await deleteFavConnect
        .connectDeleteFavouriteAcct(request, globals.token)
        .then((value) {
      //print('status code DeleteFavouriteAcct= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        DeleteFavouriteAcctResponse response =
            DeleteFavouriteAcctResponse.fromJson(responseMap);

        print("respDescDeleteFavouriteAcct: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "ลบบัญชีโปรดสำเร็จแล้ว",
              textStyle: TextStyle(fontSize: 20),
            ),
          );
          setState(() {
            getFavaouriteAcct();
          });
        }
      }
    });
  }

  Future<void> deleteOtherAcct(
      String acct_No, String acct_Name, String bankName) async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    // print('reqRefNoDeleteOtherAcct: ' + reqRefNo);
    DeleteOtherAcctRequest request = DeleteOtherAcctRequest(
        acct_Name: acct_Name,
        acct_No: acct_No,
        bankName: bankName,
        reqRefNo: reqRefNo);
    await deleteOtherAcctConnect
        .connectDeleteOtherAcct(request, globals.token)
        .then((value) {
      //print('status code DeleteOtherAcct= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        DeleteOtherAcctResponse response =
            DeleteOtherAcctResponse.fromJson(responseMap);
        print("respDescDeleteOtherAcct: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "ลบบัญชีบุคคลอื่นสำเร็จแล้ว",
              textStyle: TextStyle(fontSize: 20),
            ),
          );
          setState(() {
            getAllAccountOtherCompany();
          });
        }
      }
    });
  }

  Future<List<FavouriteAcctModelResponse>> getFavaouriteAcct() async {
    List<FavouriteAcctModelResponse> favouriteAcctList = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    // print('reqRefNoGetFavouriteUserAcct: ' + reqRefNo);
    FavouriteAcctRequest request = FavouriteAcctRequest(reqRefNo: reqRefNo);
    await favouriteAcctConnect
        .connectFavouriteAcct(request, globals.token)
        .then((value) {
      //print('status code getFavouriteUserAcct= ' + value.statusCode.toString());
      //print('body: '+value.body);
      Map<String, dynamic> responseMap = jsonDecode(value.body);
      FavouriteAcctResponse response =
          FavouriteAcctResponse.fromJson(responseMap);
      if (reqRefNo == response.reqRefNo &&
          response.respCode == ResponseCode.APPROVED) {
        if(response.listFavoriteAccount!=null){
          for (FavouriteAcctModelResponse data in response.listFavoriteAccount) {
          favouriteAcctList.add(data);
        }
        }else{
          favouriteAcctList.length=0;
        }
        
      }
    });

    return favouriteAcctList;
  }

  Future<List<OtherUserAcctModelResponse>> getAllAccountOtherCompany() async {
    List<OtherUserAcctModelResponse> otherAcctList = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();

 
    // print('reqRefNoGetOtherUserAcct: ' + reqRefNo);

    OtherUserAcctRequest request = OtherUserAcctRequest(reqRefNo: reqRefNo);
    await otherAcctConnect
        .connectOtherUserAcct(request, globals.token)
        .then((value) {
      //print('status code getOtherUserAcct= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        OtherUserAcctResponse response =
            OtherUserAcctResponse.fromJson(responseMap);
        print("respDescOtherUserAcct: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (OtherUserAcctModelResponse data in response.otherUserAcctList) {
            if(data.acct_No==null&&data.promptpay==null){
              continue;
            }else{
              otherAcctList.add(data);
            }
            
          }
          for (OtherUserAcctModelResponse data in response.otherUserAcctPromptpay) {
            if(data.acct_No==null&&data.promptpay==null){
              continue;
            }else{
              otherAcctList.add(data);
            }
          }
        }
      }
    });
    print(otherAcctList.length);
    return otherAcctList;
  }

  Future<List<CompanyUserAcctResponse>> getCompanyUserAcct() async {
    List<CompanyUserAcctResponse> res = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetCompanyUserAcct: ' + reqRefNo);
    CompanyUserAcctRequest request = CompanyUserAcctRequest(reqRefNo: reqRefNo, accountSender: this.fromAccountNumber);
    await companyUserAcctConnect
        .connectCompanyUserAcct(request, globals.token)
        .then((value) {
      //print('status code getCompanyUserAcct= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        CompanyUserAcctShowResponse response =
            CompanyUserAcctShowResponse.fromJson(responseMap);
        print("respDescCompanyUserAcct: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (CompanyUserAcctResponse data in response.userAccount) {
            res.add(data);
          }
        }
      }
    });
    return res;
  }

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
    //refreshListCompanyAccts();
    listRequest.clear();
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: this._scaffoldkey,
          backgroundColor: backgroundColor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
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
                // padding: EdgeInsets.only(
                //   left: _height * 0.015,
                //   right: _height * 0.015,
                //   top: _height * 0.038,
                // ),
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: _height * 0.015,
                            right: _height * 0.015,
                            top: _height * 0.038,
                          ),
                          child: SizedBox(
                            height: _height * 0.03,
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'จาก',
                                style: TextStyle(
                                    fontSize: _height * 0.023,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.01,
                        ),
                        Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: _height * 0.015,
                              right: _height * 0.015,
                            ),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: _height * 0.1,
                                width: _width,
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: _height,
                                      width: _width * 0.04,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: _height,
                                      width: _width * 0.2,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            checkLogoBank(fromBankName),
                                        backgroundColor: Colors.yellow,
                                        radius: _height * 0.03,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: _height,
                                      width: _width * 0.26,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: _height * 0.02,
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              fromAccountType,
                                              style: TextStyle(
                                                  fontSize: _height * 0.018),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              fromAccountNumber,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: _height * 0.018),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: _height * 0.04,
                                    ),
                                    Container(
                                      height: _height,
                                      width: _width * 0.32,
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            height: _height * 0.02,
                                          ),
                                          Container(
                                            child: Text(
                                              '${formatMoney.format(fromAvailableBalnace)}'
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: _height * 0.024),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              ' บาท',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: _height * 0.015),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.05,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: _height * 0.015,
                              right: _height * 0.015,
                            ),
                            child: SizedBox(
                              height: _height * 0.03,
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'ถึง',
                                  style: TextStyle(
                                      fontSize: _height * 0.023,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.01,
                          ),
                          Container(
                              height: _height * 0.7,
                              width: _width,
                              child: Stack(
                                children: <Widget>[
                                  ListView(
                                    children: [
                                      Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: _height * 0.015,
                                              right: _height * 0.015,
                                            ),
                                            child: new Container(
                                              color: Color(0xFF3b074b),
                                              child: new TabBar(
                                                indicatorColor:
                                                    Color(0xFFe4980e),
                                                controller: _controller,
                                                tabs: [
                                                  new Tab(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        'บัญชีบุคคลภายในบริษัท',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize:
                                                              _height * 0.023,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  new Tab(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        'บัญชีบุคคลอื่น',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: _height *
                                                                0.023),
                                                      ),
                                                    ),
                                                  ),
                                                  new Tab(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        'บัญชีโปรด',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: _height *
                                                                0.023),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: _height * 0.015,
                                              right: _height * 0.015,
                                            ),
                                            child: new Container(
                                              color: Colors.white,
                                              height: _height * 0.6,
                                              child: new TabBarView(
                                                controller: _controller,
                                                children: <Widget>[
                                                  //trasnfer company
                                                  _buildCompanyUserAccts(
                                                      context),
                                                  //other transfer
                                                  _buildOtherUserAccts(context),
                                                  //favAccts
                                                  _buildFavouriteUserAccts(
                                                      context)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                        ])
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: _height * 0.02,
            right: _height * 0.02,
            top: _height * 0.02,
          ),
          width: _width,
          height: _height,
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    width: _width,
                    height: _height * 0.1,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: _height,
                          width: _width * 0.2,
                          child: CircleAvatar(
                            backgroundImage: toBankName == null
                                ? AssetImage('assests/images/avatar-circle.png')
                                : checkLogoBank(toBankName),
                          ),
                        ),
                        SizedBox(
                          width: _height * 0.02,
                        ),
                        Container(
                          child: Text(
                            toBankName == null
                                ? 'โอนเงินบุคคลอื่น (พร้อมเพย์)'
                                : checkNameBank(toBankName),
                            style: TextStyle(fontSize: _height * 0.024),
                          ),
                        )
                      ],
                    )),
                Divider(
                  height: _height * 0.01,
                ),
                Container(
                  width: _width,
                  height: _height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'หมายเลขบัญชี',
                        style: TextStyle(fontSize: _height * 0.024),
                      ),
                      Text(toAcctNumber,
                          style: TextStyle(
                              fontSize: _height * 0.024, color: Colors.grey))
                    ],
                  ),
                ),
                Divider(
                  height: _height * 0.01,
                ),
                Container(
                  
                  width: _width,
                  height: _height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'จำนวนเงิน (บาท)',
                          style: TextStyle(fontSize: _height * 0.024),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                        
                        validator: (value) {
                          value = amountController.text;
                          if (value.isEmpty) {
                            return 'กรุณาใส่จำนวนเงิน';
                          }
                          return null;
                        },
                        
                        style: TextStyle(
                            color: Colors.black, fontSize: _height * 0.023),
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        onChanged: (value){
                          
                        },
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'ระบุจำนวนเงิน',
                          hintStyle: TextStyle(fontSize: _height * 0.02),
                          labelStyle: TextStyle(fontSize: _height * 0.02),

                        ),
                        inputFormatters: [
                          
                        ],
                      ),
                      )
                      
                    ],
                  ),
                ),
                Divider(
                  height: _height * 0.01,
                ),
                Container(
                  width: _width,
                  height: _height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'บันทึก',
                        style: TextStyle(fontSize: _height * 0.024),
                      ),
                      Wrap(
                        spacing: _height * 0.01,
                        children: <Widget>[
                          Container(
                            height: _height * 0.05,
                            width: _width * 0.4,
                            child: TextFormField(
                              validator: (value) {
                                value = noteController.text;
                                if (value.isEmpty) {
                                  return 'กรุณากรอกข้อมูล';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: _height * 0.023),
                              keyboardType: TextInputType.text,
                              controller: noteController,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                hintText: 'ระบุบันทึกการโอน',
                                hintStyle: TextStyle(fontSize: _height * 0.02),
                                labelStyle: TextStyle(fontSize: _height * 0.02),
                                //enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  height: _height * 0.01,
                ),
                SizedBox(
                  height: _height * 0.3,
                ),
                _buildButtonCheckTransf(context)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> checkValidate() async {
    if (_formKey.currentState.validate()) {
       
      print('in buttonSheet');
      print('************** โอนเงินจาก *******************');
      print('ประเภทบัญชี: '+fromAccountType);
      print('หมายเลขบัญชี: '+fromAccountNumber);
      print('ธนาคาร: '+fromBankName);
      print('ชื่อบัญชี: '+fromAccountName);
      print('************** รายละเอียด *******************');
      print('ประเภทการโอน: '+transfType);
      print('จำนวนเงิน: '+amountController.text);
      print('บันทึก: '+noteController.text);
      print('************** ถึง *******************');
      print('หมายเลขบัญชี: '+toAcctNumber);
      print('ธนาคาร: '+toBankName);
      print('ชื่อบัญชี: '+toAcctName);

      listRequest.add(
        InquilyInfoTransferGroupModelRequest(
          bank_Name_Recipient: toBankName,
          bank_Name_Sender: fromBankName,
          recipient_account_No: toAcctNumber,
          recipient_account_No_name_En: "",
          recipient_account_No_name_Th: toAcctName,
          sender_Account_No: fromAccountNumber,
          sender_Account_No_name_En: "",
          sender_Account_No_name_Th: fromAccountName,
          transAmount: double.parse(amountController.text),
        )
      );

       String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
       //print('reqRefNoInquiryInfoTransferGroup: ' + reqRefNo);
    InquilyInfoTransferGroupRequest request =
        InquilyInfoTransferGroupRequest(reqRefNo: reqRefNo,listRequest: listRequest);
    await inquiltInfoConnect.connectInquilyInfoTransferGroup(request, globals.token)
        .then((value) {
      //print('status code InquiryInfoTransferGroup= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        InquilyInfoTransferGroupResponse response =
            InquilyInfoTransferGroupResponse.fromJson(responseMap);
        print("respDescInquiryInfoTransferGroup: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
              Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckTransferScreen(
                    fromAcctName: response.listResponse[0].sender_Account_No_name_Th,
                    transfType: transfType,
                    fromAcctNumber: response.listResponse[0].sender_Account_No,
                    fromAcctType: fromAccountType,
                    fromBankName: response.listResponse[0].bank_Name_Sender,
                    toAcctNumber: response.listResponse[0].recipient_account_No,
                    toBankName: response.listResponse[0].bank_Name_Recipient,
                    toAcctName: response.listResponse[0].recipient_account_No_name_Th,
                    toAmount: response.listResponse[0].transAmount,
                    toNote: noteController.text,
                    fee: response.listResponse[0].fee,
                  )));
          
        }else{
          print("ERROR");
        }
        
      }
    });

      
    } else {
      print('Please Enter data!!');
    }
  }

  Widget _buildButtonCheckTransf(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        checkValidate();
      },
      child: Container(
        height: _height * 0.08,
        decoration: BoxDecoration(
          color: Color(0xFF3b074b),
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          'ตรวจสอบข้อมูล',
          style: TextStyle(fontSize: _height * 0.023, color: Colors.white),
        ),
      ),
    );
    // );
  }

  Widget _buildFavouriteUserAccts(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      child: Column(
        children: <Widget>[
          Container(
            height: _height * 0.6,
            width: _width,
            child: RefreshIndicator(
              key: refreshKey,
              onRefresh: refreshListFavouriteAcctUser,
              child: FutureBuilder<List<FavouriteAcctModelResponse>>(
                future: getFavaouriteAcct(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var getAllFavourite = snapshot.data;
                    int lengthGetAllFavourite = getAllFavourite.length;
                    return lengthGetAllFavourite!=0?
                    ListView.builder(
                      itemCount: lengthGetAllFavourite,
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                            transfType = "TTAF";
                            toAcctName = getAllFavourite[index].acctName;
                            
                            toAcctNumber = getAllFavourite[index].acctNo;
                            toBankName = getAllFavourite[index].bankName;
                            this._scaffoldkey.currentState.showBottomSheet(
                                (context) => _buildBottomSheet(context));
                          },
                          child: Slidable(
                            actionPane: SlidableScrollActionPane(),
                            secondaryActions: [
                              IconSlideAction(
                                caption: 'Delete',
                                icon: Icons.delete,
                                color: Color(0xFF3b074b),
                                onTap: () {
                                  deleteFavouriteAcct(
                                    getAllFavourite[index].acctNo,
                                      getAllFavourite[index].acctName,
                                      
                                      getAllFavourite[index].bankName);
                                },
                              )
                            ],
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.yellow,
                                    backgroundImage: checkLogoBank(
                                        getAllFavourite[index].bankName),
                                  ),
                                  title: Text(
                                    getAllFavourite[index].acctName,
                                    style: TextStyle(
                                        fontSize: _height * 0.023,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                    'หมายเลขบัญชี ' +
                                        getAllFavourite[index].acctNo,
                                    style: TextStyle(
                                        fontSize: _height * 0.023,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFF3b074b),
                                    size: _height * 0.023,
                                  ),
                                ),
                                Divider()
                              ],
                            ),
                          ),
                        );
                      },
                    ):Center(
                      child: Container(
                        child: Text('ยังไม่ได้เพิ่มผู้รับเงินจากรายการโปรด', style: TextStyle(fontSize: _height*0.024),),

                    ),);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOtherUserAccts(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      child: Column(
        children: <Widget>[
          Container(
            height: _height * 0.6,
            width: _width,
            child: RefreshIndicator(
              key: refreshKey,
              onRefresh: refreshListOtherUserAccts,
              child: FutureBuilder<List<OtherUserAcctModelResponse>>(
                future: getAllAccountOtherCompany(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var acctOtherCompany = snapshot.data;
                    var lengthAcctOtherCompany = acctOtherCompany.length;
                    return ListView.builder(
                      itemCount: lengthAcctOtherCompany,
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                            transfType = "TTAOP";
                            toAcctName = acctOtherCompany[index].acct_Name;
                            toAcctNumber = acctOtherCompany[index].acct_No==null?acctOtherCompany[index].promptpay:acctOtherCompany[index].acct_No;
                            toBankName = acctOtherCompany[index].bank_Name==null?'ไม่มีธนาคาร':acctOtherCompany[index].bank_Name;
                            this._scaffoldkey.currentState.showBottomSheet(
                                (context) => _buildBottomSheet(context));
                          },
                          child: Slidable(
                            actionPane: SlidableScrollActionPane(),
                            secondaryActions: [
                              IconSlideAction(
                                caption: 'Delete',
                                icon: Icons.delete,
                                color: Color(0xFF3b074b),
                                onTap: () {
                                  print('***********ต้องการลบบัญชีบุคคลอื่น************');
                                  acctOtherCompany[index].acct_No==null?
                                  print('พร้อมเพย์ '+acctOtherCompany[index].promptpay):print('บัญชี '+acctOtherCompany[index].acct_No);
                                  print(acctOtherCompany[index].acct_Name);
                                  print(acctOtherCompany[index].bank_Name);
                                  deleteOtherAcct(
                                      acctOtherCompany[index].acct_No==null?
                                      acctOtherCompany[index].promptpay:acctOtherCompany[index].acct_No,
                                      acctOtherCompany[index].acct_Name,
                                      acctOtherCompany[index].bank_Name==null?'ไม่มีธนาคาร':acctOtherCompany[index].bank_Name);
                                },
                              )
                            ],
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage: func.checkLogoBank(
                                          acctOtherCompany[index].bank_Name)),
                                  // backgroundImage: checkLogoBank(
                                  //     acctOtherCompany[index].bank_Name),

                                  title: Text(
                                    acctOtherCompany[index].acct_Name,
                                    style: TextStyle(
                                        fontSize: _height * 0.023,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: acctOtherCompany[index].acct_No!=null?
                                  Text(
                                    'หมายเลขบัญชี ' +
                                        acctOtherCompany[index].acct_No,
                                    style: TextStyle(
                                        fontSize: _height * 0.023,
                                        fontWeight: FontWeight.w500),
                                  ):
                                  Text(
                                    'หมายเลขพร้อมเพย์ ' +
                                        acctOtherCompany[index].promptpay,
                                    style: TextStyle(
                                        fontSize: _height * 0.023,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFF3b074b),
                                    size: _height * 0.023,
                                  ),
                                ),
                                Divider()
                              ],
                            ),
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
    );
  }

  Widget _buildCompanyUserAccts(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      child: Column(
        children: <Widget>[
          Container(
            height: _height * 0.6,
            width: _width,
            child: RefreshIndicator(
              key: refreshKey,
              onRefresh: refreshListCompanyAccts,
              child: FutureBuilder<List<CompanyUserAcctResponse>>(
                future: getCompanyUserAcct(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var acctStaffs = snapshot.data;
                    int lenthAcctStaff = acctStaffs.length;
                    return ListView.builder(
                      itemCount: lenthAcctStaff,
                      itemBuilder: (context, int index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                transfType = "TTAUC";
                                toAcctName = acctStaffs[index].accountName;
                                toLName = '';
                                toAcctNumber = acctStaffs[index].accountNo;
                                toBankName = acctStaffs[index].bankName;
                                this._scaffoldkey.currentState.showBottomSheet(
                                    (context) => _buildBottomSheet(context));
                                //showModalBottomSheet(context: context, builder: (ctx)=>_buildBottomSheet(ctx));
                                //showWidgetTransferInCompany();
                                //print(viewVisibleTransferInCompany);
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      checkLogoBank(acctStaffs[index].bankName),
                                ),
                                title: Text(
                                  acctStaffs[index].accountName ,
                                  style: TextStyle(
                                      fontSize: _height * 0.023,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  'หมายเลขบัญชี ' + acctStaffs[index].accountNo,
                                  style: TextStyle(
                                      fontSize: _height * 0.023,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xFF3b074b),
                                  size: _height * 0.023,
                                ),
                              ),
                            ),
                            Divider()
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget _moneyTextField() {
//       return TextField(
//         keyboardType: TextInputType.number,
//         inputFormatters: [CurrencyTextInputFormatter(
//           locale: 'th',
//           decimalDigits: 0
//         ),],
//         showCursor: false,
//         style: Theme.of(context).textTheme.headline5,
//         decoration: InputDecoration(
//             suffixText: "บาท",
//             suffixStyle: TextStyle(
//                 fontFamily: 'Kanit',
//                 fontSize: screenHeight * 0.025,
//                 color: Colors.grey),
//             icon: const Icon(Icons.attach_money),
//             labelText: 'ใส่จำนวนเงิน',
//             labelStyle: TextStyle(
//                 fontFamily: 'Kanit',
//                 fontSize: screenHeight * 0.025,
//                 color: Colors.grey),
//             errorText: _numberInputValid ? null : 'โปรดใส่จำนวนเงิน',
//             errorStyle: TextStyle(
//                 fontFamily: 'Kanit',
//                 fontSize: screenHeight * 0.018,
//                 color: Colors.red),
//             border: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10)))),
//         onChanged: (String val) {
//           val = val.replaceAll(",", "");

//           val = val.substring(0, val.length - 2);//หลักพัน
//           val = val+"00";

//           globals.amount = int.parse(val);
//           print(globals.amount);

//           loanAmount = moneyFormat(val);
//           debugPrint('parse value = $val');
//           if (val == null) {
//             setState(() {
//               _numberInputValid = false;
//             });
//           } else {
//             setState(() {
//               _numberInputValid = true;
//             });
//           }
//           print(val);

//           month = [];
//           int maxMonthInTextField;
//           final v = int.parse(val);
//           print(v);
//           if(v>0 && v <= 50000 )
//           {
//             setState(() {
//               maxMonthInTextField = 12;
//             });
//           }
//           if(v>50000&&v<=100000)
//           {
//             setState(() {
//               maxMonthInTextField = 24;
//             });
//           }
//           if(v>100000&&v<=1000000)
//           {
//             setState(() {
//               maxMonthInTextField = 48;
//             });
//           }
//           else{
//             setState(() {
//               maxMonthInTextField = 60;
//             });
//           }
//           print(maxMonthInTextField);
//           setState(() {
//             setMonth(maxMonthInTextField);
//           });

//         },

//       );
//     }
