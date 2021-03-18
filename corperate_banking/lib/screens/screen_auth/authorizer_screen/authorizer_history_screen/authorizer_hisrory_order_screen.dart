import 'dart:convert';

import 'package:corperate_banking/global_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rest_package/bean/authorizor_bean/authorizer_history_detail_request.dart';
import 'package:rest_package/bean/authorizor_bean/authorizer_history_detail_response.dart';
import 'package:rest_package/connection/authorizer_connection/authorizer_history_detail_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;
class AuthorizerHistoryOrderScreen extends StatefulWidget {
  String tracNo;
  AuthorizerHistoryOrderScreen({this.tracNo});
  @override
  _AuthorizerHistoryOrderScreenState createState() => _AuthorizerHistoryOrderScreenState(tracNo: tracNo);
}

class _AuthorizerHistoryOrderScreenState extends State<AuthorizerHistoryOrderScreen> {
  String tracNo;
  _AuthorizerHistoryOrderScreenState({this.tracNo});
  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  XSignature randReqRefNo = XSignature();
   FunctionGlobal func = FunctionGlobal();
  AuthorizerHistoryDetailConnection authorHistoryDetailConnect = AuthorizerHistoryDetailConnection(globals.iPV4, '8080');


  Future<AuthorizerHistoryDetailResponse> getAutherizerHistoryDetail() async {
    AuthorizerHistoryDetailResponse res = new AuthorizerHistoryDetailResponse();
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefGetgetAutherizerHistoryDetail: ' + reqRefNo);
    AuthorizerHistoryDetailRequest request =
        AuthorizerHistoryDetailRequest(reqRefNo: reqRefNo, trace_No: tracNo );
    await authorHistoryDetailConnect
        .connectAuthorizerHistoryDetail(request, globals.token)
        .then((value) {
      //print('status code getAutherizerHistoryDetail= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: '+value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        AuthorizerHistoryDetailResponse response =
            AuthorizerHistoryDetailResponse.fromJson(responseMap);
        print("respDescGetgetAutherizerHistoryDetail: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          res.traceNo = response.traceNo;
          res.dateTime = response.dateTime;
          res.sender_Account_No = response.sender_Account_No;
          res.bank_Name_Sender_Th = response.bank_Name_Sender_Th;
          res.bank_Name_Sender_En = response.bank_Name_Sender_En;
          res.bank_Name_Recipient = response.bank_Name_Recipient;
          res.recipient_account_No = response.recipient_account_No;
          res.recipient_account_No_name_Th =
              response.recipient_account_No_name_Th;
          res.recipient_account_No_name_En =
              response.recipient_account_No_name_En;
          res.amount = response.amount;
          res.note = response.note;
          res.fee = response.fee;
          res.name_Check = response.name_Check;
          res.sender_Account_Type = response.sender_Account_Type;
          res.trnStatus = response.trnStatus;
        }
      }
    });
    
    return res;
    
  }







  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
      return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, _height),
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Container(
              width: _width,
              height: _height,
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //         colors: [Colors.black, Color(0xFF3b074b)])),
            ),
            _buildData(context),
            
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, double _height) {
    return AppBar(
      backgroundColor: backgroundMainColor,
      centerTitle: true,
      title: Text(
        'เลขที่รายกาาร: ' + tracNo,
        style: TextStyle(fontSize: _height * 0.03),
      ),
    );
  }

  Widget _buildData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return FutureBuilder<AuthorizerHistoryDetailResponse>(
      future: getAutherizerHistoryDetail(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else{
          var data=snapshot.data;
          return Container(
        padding: EdgeInsets.only(left: _height * 0.03, right: _height * 0.03, top: _height*0.03),
        alignment: Alignment.topCenter,
        width: _width,
        height: _height,
        child: Container(
          padding: EdgeInsets.only(
              left: _height * 0.02, right: _height * 0.02, top: _height * 0.01),
          width: _width,
          height: _height * 0.63,
          child: Stack(
            children: [
              Container(
                width: _width,
                height: _height,
                child: Image.network('https://t3.ftcdn.net/jpg/02/49/42/16/360_F_249421624_COqIjrl5UpwB8RA3u3xJe2TGI1P0IGHL.jpg',fit: BoxFit.cover,)
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.01),
                    child: Text(
                      'รายการโอนเงิน ',
                      style: TextStyle(
                          fontSize: _height * 0.03,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.01),
                    child: Text(Jiffy(data.dateTime).yMMMMEEEEdjm,style: TextStyle(fontSize: _height*0.023),),
                  ),
                  Divider(thickness: _height*0.002,),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.02),
                    child: Column(
                      children: [
                        Row(children: <Widget>[
                          CircleAvatar( 
                            radius: _height*0.04,
                            backgroundImage: data.bank_Name_Sender_Th==null?
                            AssetImage('assests/images/avatar-circle.png'):
                            func.checkLogoBank(data.bank_Name_Sender_Th)
                           
                          ),
                          SizedBox(width: _height*0.04,),
                          Column(
                            children: [
                              Text(data.sender_Account_Type,style: TextStyle(fontSize: _height*0.023,),),
                              Text(data.sender_Account_No,style: TextStyle(fontSize: _height*0.023,color: Colors.grey[600]),)
                            ],
                          ),
                          
                        ],),
                        Padding(
                          padding: EdgeInsets.only(left: _height*0.035),
                          child: Row(
                            children: [
                              Container(
                                height: _height*0.1,
                                width: _width*0.01,
                                color: Color(0xFF3b074b),
                              ),
                              SizedBox(width: _height*0.04,),
                              Icon(Icons.arrow_downward,color: Color(0xFF3b074b),)
                            ],
                          ),
                        ),
                        Row(children: <Widget>[
                          CircleAvatar( 
                            radius: _height*0.04,
                            backgroundImage: data.bank_Name_Recipient==null?
                            AssetImage('assests/images/avatar-circle.png'):

                            func.checkLogoBank(data.bank_Name_Recipient)
                          ),
                          SizedBox(width: _height*0.04,),
                          Column(
                            children: [
                              Text(data.recipient_account_No_name_Th,style: TextStyle(fontSize: _height*0.023,),),
                              Text(data.recipient_account_No,style: TextStyle(fontSize: _height*0.023,color: Colors.grey[600]),)
                            ],
                          ),
                          
                        ],),
                        

                      ],
                    ),
                  ),
                  SizedBox(height: _height*0.03,),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.03, right: _height*0.03),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('เลขที่รายการ:',style: TextStyle(fontSize: _height*0.024,),),
                      Text(data.traceNo,style: TextStyle(fontSize: _height*0.023,color: Colors.grey[600]),)
                    ],),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.03, right: _height*0.03),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('จำนวนเงิน:',style: TextStyle(fontSize: _height*0.024,),),
                      Row(
                        children: [
                          Text('${formatMoney.format(data.amount)}',style: TextStyle(fontSize: _height*0.03,color: Colors.grey[600]),),
                          Text(' บาท',style: TextStyle(fontSize: _height*0.024,),)
                        ],
                      )
                    ],),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.03, right: _height*0.03),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('ค่าธรรมเนียม:',style: TextStyle(fontSize: _height*0.024,),),
                      Row(
                        children: [
                          Text('${formatMoney.format(data.fee)}',style: TextStyle(fontSize: _height*0.03,color: Colors.grey[600]),),
                          Text(' บาท',style: TextStyle(fontSize: _height*0.024,),)
                        ],
                      )
                    ],),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.03, right: _height*0.03),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('บันทึก:',style: TextStyle(fontSize: _height*0.024,),),
                      Text( data.note==null?' ':data.note,style: TextStyle(fontSize: _height*0.024,color: Colors.grey[600]),),
                    ],),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.03, right: _height*0.03),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('สถานะ:',style: TextStyle(fontSize: _height*0.024,),),
                      func.checkStatus(context,data.trnStatus)
                    ],),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.03, right: _height*0.03),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('ผู้ตรวจสอบ:',style: TextStyle(fontSize: _height*0.024,),),
                      Text(data.name_Check,style: TextStyle(fontSize: _height*0.024,color: Colors.grey[600]),)
                    ],),
                  ),
                  
                ],
              ),
              
            ],
          ),
        ),
      );
        }
      },
          
    );
}
}