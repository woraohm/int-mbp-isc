import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rest_package/bean/transf_order_detail_request.dart';
import 'package:rest_package/bean/transf_order_detail_response.dart';
import 'package:rest_package/connection/transf_order_detail_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/model/transf_order_detail_model_response.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:sweetalert/sweetalert.dart';

class ScanDataTransfScreen extends StatefulWidget {
  String tracNo;
  ScanDataTransfScreen({this.tracNo});
  @override
  _ScanDataTransfScreenState createState() =>
      _ScanDataTransfScreenState(tracNo: tracNo);
}


class _ScanDataTransfScreenState extends State<ScanDataTransfScreen> {
  String tracNo;
  _ScanDataTransfScreenState({this.tracNo});
  TransfOrderDetailConnection transfOrderDetailConnect =
      TransfOrderDetailConnection(globals.iPV4, '8080');
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
        return AssetImage('assests/images/avatar-circle.png');break;
    }
  }
  Future<TransfOrderDetailModelResponse> getOrderDetail() async {
    TransfOrderDetailModelResponse res = new TransfOrderDetailModelResponse();
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoGetOrderDetail: ' + reqRefNo);
    TransfOrderDetailRequest request =
        TransfOrderDetailRequest(reqRefNo: reqRefNo, traceNo: tracNo);
    await transfOrderDetailConnect
        .transfOrderDetailConnection(request, globals.token)
        .then((value) {
      //print('status code GetOrderDetail= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        TransfOrderDetailResponse response =
            TransfOrderDetailResponse.fromJson(responseMap);
        print("respDescCodeGetOrderDetail: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          res.dateTime = response.dateTime;
          res.fee = response.fee;
          res.note = response.note;
          res.recipient_account_No = response.recipient_account_No;
          res.recipient_account_No_name_En =
              response.recipient_account_No_name_En;
          res.recipient_account_No_name_Th =
              response.recipient_account_No_name_Th;
          res.sender_Account_No = response.sender_Account_No;
          res.lk_acct_type_name= response.lk_acct_type_name;
          res.traceNo = response.traceNo;
          res.trnStatus = response.trnStatus;
          res.bank_Name_Recipient = response.bank_Name_Recipient;
          res.bank_Name_Sender = response.bank_Name_Sender;
          res.amount = response.amount;
        }else{
          // Navigator.pop(context);
          
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
        appBar: _buildAppBar(_height),
        body: Stack(
          children: <Widget>[
            _buildBackgroundImageBlur(context),
            Column(
              children: <Widget>[
                SizedBox(
                  height: _height * 0.04,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: EdgeInsets.only(
                          left: _height * 0.01, right: _height * 0.01),
                      color: Colors.white,
                      child: Text(
                        'เลขที่รายการ: ' + tracNo,
                        style: TextStyle(
                          fontSize: _height * 0.024,
                          fontWeight: FontWeight.w500,
                          color: Colors.pink,
                        ),
                      )),
                ),
                Container(
                  height: _height * 0.008,
                  width: _width,
                  color: Colors.white,
                ),
                SizedBox(
                  height: _height * 0.03,
                ),
                FutureBuilder<TransfOrderDetailModelResponse>(
                  future: getOrderDetail(),
                  builder: (context,snaphot){
                    if(!snaphot.hasData){
                      print('11111111');
                      //Navigator.pop(context);
                      return Center(child: CircularProgressIndicator(),);
                    }else{
                    
                      var data=snaphot.data;
                      print(data.trnStatus);
                      return _buildDataStatus(context, data.trnStatus);
                    }
                  },
                  ),
                  SizedBox(height: _height*0.04,),
                  Padding(
                    padding: EdgeInsets.only(left: _height*0.02,right: _height*0.02),
                    child: Container(
                      width: _width,
                      height: _height*0.5,
                      
                       child: _buildData(context),
                      ),
                      
                    ),
                  
            
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(
    double _height,
  ) {
    return AppBar(
        backgroundColor: Color(0xFF3b074b),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'สถานะการโอน',
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }

  Widget _buildBackgroundImageBlur(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      color: Color(0xFFeaecf0),
      
    );
  }

  Widget _buildDataStatus(BuildContext context, String trnStatus) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    switch (trnStatus) {
      case "Waiting for Check":
        return Container(
          width: _width,
          height: _height * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: _height * 0.05,
                      )),
                  Text(
                    'สร้างรายการ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.green,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: _height * 0.05,
                      )),
                  Text(
                    'รอตรวจสอบ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.grey,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: Icon(
                        Icons.circle,
                        color: Colors.grey[400],
                        size: _height * 0.05,
                      )),
                  Text(
                    'รออนุมัติ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.grey,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: Icon(
                        Icons.circle,
                        color: Colors.grey[400],
                        size: _height * 0.05,
                      )),
                  Text(
                    'สำเร็จ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
            ],
          ),
        );
        break;
        case "Cancle By Checker":
        return Container(
          width: _width,
          height: _height * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: _height * 0.05,
                      )),
                  Text(
                    'สร้างรายการ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.green,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: Icon(
                        Icons.close_sharp,
                        color: Colors.white,
                        size: _height * 0.05,
                      )),
                  Text(
                    'รอตรวจสอบ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.grey,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: Icon(
                        Icons.circle,
                        color: Colors.grey[400],
                        size: _height * 0.05,
                      )),
                  Text(
                    'รออนุมัติ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.grey,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: Icon(
                        Icons.circle,
                        color: Colors.grey[400],
                        size: _height * 0.05,
                      )),
                  Text(
                    'สำเร็จ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
            ],
          ),
        );
        break;
        case "Waiting for Approval":
        return Container(
          width: _width,
          height: _height * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: _height * 0.05,
                      )),
                  Text(
                    'สร้างรายการ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.green,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: _height * 0.05,
                      )),
                  Text(
                    'รอตรวจสอบ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.green,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: _height * 0.05,
                      )),
                  Text(
                    'รออนุมัติ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.grey,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: Icon(
                        Icons.circle,
                        color: Colors.grey[400],
                        size: _height * 0.05,
                      )),
                  Text(
                    'สำเร็จ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
            ],
          ),
        );
        break;
        case "Cancle By Authorizer":
        return Container(
          width: _width,
          height: _height * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: _height * 0.05,
                      )),
                  Text(
                    'สร้างรายการ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.green,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: _height * 0.05,
                      )),
                  Text(
                    'รอตรวจสอบ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.green,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: Icon(
                        Icons.close_sharp,
                        color: Colors.white,
                        size: _height * 0.05,
                      )),
                  Text(
                    'รออนุมัติ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.grey,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                      child: Icon(
                        Icons.circle,
                        color: Colors.grey[400],
                        size: _height * 0.05,
                      )),
                  Text(
                    'สำเร็จ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
            ],
          ),
        );
        break;
        case "Approved":
        return Container(
          width: _width,
          height: _height * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: _height * 0.05,
                      )),
                  Text(
                    'สร้างรายการ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.green,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: _height * 0.05,
                      )),
                  Text(
                    'รอตรวจสอบ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.green,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: _height * 0.05,
                      )),
                  Text(
                    'รออนุมัติ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _width * 0.12,
                    height: _height * 0.012,
                    color: Colors.green,
                  ),
                  Container()
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height*0.023,),
                  Container(
                      alignment: Alignment.center,
                      width: _width * 0.13,
                      height: _height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: _height * 0.05,
                      )),
                  Text(
                    'สำเร็จ',
                    style: TextStyle(fontSize: _height * 0.02),
                  )
                ],
              ),
            ],
          ),
        );
        break;
      default:
    }
    
  }
  Widget _buildData(BuildContext context){
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return FutureBuilder<TransfOrderDetailModelResponse>(
      future: getOrderDetail(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else{
          var data = snapshot.data;
          return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.only(left: _height*0.01,right: _height*0.01,top: _height*0.01),
            child: Text('โอนเงินจาก',style: TextStyle(fontSize: _height*0.023),),
          ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: _height*0.07,right: _height*0.01,top: _height*0.01),
                child: Container(
                  padding: EdgeInsets.only(left: _height*0.06),
                  alignment: Alignment.centerLeft,
                  width: _width,
                  height: _height*0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white
                  ),
                  child: ListTile(
                    title: Text(data.lk_acct_type_name, style: TextStyle(fontSize: _height*0.023),),
                    subtitle: Text(data.sender_Account_No, style: TextStyle(fontSize: _height*0.023),),
                  )
                  
                )
              ),
              Padding(
                padding:  EdgeInsets.only(left: _height*0.01,right: _height*0.01,top: _height*0.01),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: _width,
                  height: _height*0.1,
                  
                  child: Container(
                    padding: EdgeInsets.only(left: _height*0.03,),
                    child: CircleAvatar(
                      radius: _height*0.04,
                      backgroundImage: checkLogoBank(data.bank_Name_Sender),
                    ),
                    ),
                )
              ),
              
            ],
          ),
          SizedBox(height: _height*0.02,),
          Padding(
            padding:  EdgeInsets.only(left: _height*0.01,right: _height*0.01,top: _height*0.01),
            child: Text('ถึง',style: TextStyle(fontSize: _height*0.023),),
          ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: _height*0.07,right: _height*0.01,top: _height*0.01),
                child: Container(
                  padding: EdgeInsets.only(left: _height*0.06),
                  alignment: Alignment.centerLeft,
                  width: _width,
                  height: _height*0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white
                  ),
                  child: ListTile(
                    title: Text(data.recipient_account_No_name_Th, style: TextStyle(fontSize: _height*0.023),),
                    subtitle: Text(data.recipient_account_No, style: TextStyle(fontSize: _height*0.023),),
                  )
                  
                )
              ),
              Padding(
                padding:  EdgeInsets.only(left: _height*0.01,right: _height*0.01,top: _height*0.01),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: _width,
                  height: _height*0.1,
                  
                  child: Container(
                    padding: EdgeInsets.only(left: _height*0.03,),
                    child: CircleAvatar(
                      radius: _height*0.04,
                      backgroundImage: 
                      data.bank_Name_Recipient==null?
                      AssetImage('assests/images/avatar-circle.png'):
                      checkLogoBank(data.bank_Name_Recipient),
                    ),
                    ),
                )
              ),
              
            ],
          ),
          
      ],);
        }
      },
       
    );
  }
}
