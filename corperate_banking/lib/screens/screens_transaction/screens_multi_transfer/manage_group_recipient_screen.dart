import 'dart:convert';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/select_account_to_add_group_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/manage_recipient_screen.dart';
import 'package:flutter/material.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rest_package/bean/change_group_request.dart';
import 'package:rest_package/bean/change_group_response.dart';
import 'package:rest_package/bean/manage_group_request.dart';
import 'package:rest_package/bean/manage_group_response.dart';
import 'package:rest_package/connection/change_group_connection.dart';
import 'package:rest_package/connection/manage_group_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/model/manage_group_model_response.dart';

class ManageGroupRecipientScreen extends StatefulWidget {
  String groupName;
 

  ManageGroupRecipientScreen({this.groupName});
  @override
  _ManageGroupRecipientScreenState createState() =>
      _ManageGroupRecipientScreenState(groupName: groupName);
}

class _ManageGroupRecipientScreenState
    extends State<ManageGroupRecipientScreen> {
  String groupName;

  _ManageGroupRecipientScreenState({this.groupName});
  
  String message;
  bool isChangeName=false;
  int countAcct = 0;
  XSignature randReqRefNo = XSignature();
  FunctionGlobal func = FunctionGlobal();
  TextEditingController editController = TextEditingController();

  ManageGroupConnection manageGroupConnection =
      ManageGroupConnection(globals.iPV4, '8080');
  ChangeGroupConnection changeGroupConnect =
      ChangeGroupConnection(globals.iPV4, '8080');

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

          }else{
            res.length=0;

          }
          
        }
      }
    });

    return res;
  }

  Future<void> changeGroup() async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNochangeGroup: ' + reqRefNo);
    ChangeGroupRequest request = ChangeGroupRequest(
        reqRefNo: reqRefNo,
        groupNameOld: groupName,
        groupNameNew: editController.text);
    await changeGroupConnect
        .connectChangeGroup(request, globals.token)
        .then((value) {
      //print('status code changeGroup= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        ChangeGroupResponse response =
            ChangeGroupResponse.fromJson(responseMap);
        print("respDescchangeGroup: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          this.isChangeName=true;
          this.groupName = response.groupName;
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "เปลี่ยนชื่อกลุ่มเรียบร้อย",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "กรุณาทำรายการใหม่อีกครั้ง",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    });
  }
  

  @override
  void initState(){
    super.initState();
    setState(() {
      this.isChangeName=false;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: this.isChangeName==false?
          IconButton(icon: Icon(Icons.arrow_back_ios), 
          onPressed: ()=>Navigator.pop(context)):
          Container(),
          title: Text('จัดการกลุ่มผู้รับเงิน',style: TextStyle(fontSize: _height*0.03),),
        ),
        backgroundColor: backgroundColor,
        body: FutureBuilder<List<ManageGroupModelResponse>>(
          future: getMemberList(groupName),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = snapshot.data;
              int lengthData = data.length;
              this.countAcct = lengthData;
              return Stack(
                children: <Widget>[
                  Container(
                    width: _width,
                    height: _height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildGroupNameCreate(context),
                        SizedBox(
                          height: _height * 0.01,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child:
                                Text('หนึ่งกลุ่มสามารถมีผู้รับได้สูงสุด 10 คน',
                                    style: TextStyle(
                                      fontSize: _height * 0.024,
                                      color: Colors.grey,
                                    ))),
                        SizedBox(
                          height: _height * 0.02,
                        ),
                        _buildButtonAddAccount(context),
                        SizedBox(
                          height: _height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: _height * 0.02),
                          child:
                              Text('จำนวนผู้รับเงิน: ' + countAcct.toString(),
                                  style: TextStyle(
                                    fontSize: _height * 0.024,
                                    color: Colors.grey,
                                  )),
                        ),
                        _buildAddReceipientAccount(context, data)
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: _width,
                    height: _height,
                    child: _buildButtonSave(context),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildGroupNameCreate(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
          left: _height * 0.02, right: _height * 0.02, top: _height * 0.01),
      width: _width,
      height: _height * 0.16,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ชื่อกลุ่ม',
            style: TextStyle(fontSize: _height * 0.03),
          ),
          SizedBox(
            height: _height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                groupName,
                style: TextStyle(fontSize: _height * 0.03),
              ),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: backgroundMainColor,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          elevation: 5,
                          title: Text('แก้ไขชื่อใหม่',
                              style: TextStyle(
                                fontSize: _height * 0.03,
                                color: Colors.white,
                              )),
                          backgroundColor: Color(0xFF3b074b),
                          content: Container(
                            height: _height * 0.1,
                            width: _width,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    alignment: Alignment.center,
                                    width: _width,
                                    height: _height * 0.05,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: TextFormField(
                                      controller: editController,
                                      style: TextStyle(
                                          fontSize: _height * 0.024,
                                          color: Colors.white),
                                      onChanged: (String str) {
                                        //this.groupName = editController.text;
                                      },
                                    )),
                                Container(
                                  alignment: Alignment.centerRight,
                                  height: _height * 0.05,
                                  width: _width,
                                  child: InkWell(
                                    onTap: () => changeGroup(),
                                    child: Text('ตกลง',
                                        style: TextStyle(
                                          fontSize: _height * 0.03,
                                          color: Colors.white,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonAddAccount(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: _height * 0.02, right: _height * 0.02),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddAccountToGroupScreen(
                        groupName: groupName,
                      )));
        },
        child: Container(
          alignment: Alignment.center,
          width: _width,
          height: _height * 0.06,
          decoration:
              BoxDecoration(border: Border.all(color: backgroundMainColor)),
          child: Text('เพิ่มผู้รับเงิน',
              style: TextStyle(
                fontSize: _height * 0.025,
                color: backgroundMainColor,
              )),
        ),
      ),
    );
  }

  Widget _buildAddReceipientAccount(
      BuildContext context, List<ManageGroupModelResponse> data) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return Container(
        alignment: Alignment.center,
        width: _width,
        height: _height * 0.45,
        color: Colors.white,
        child: this.countAcct != 0
            ? ListView.builder(
                itemCount: this.countAcct,
                itemBuilder: (context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // print(data[index].amount);
                          // print(data[index].acctNo);
                          // print(data[index].acctName);
                          // print(data[index].bankName);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManageRecipientScreen(
                                        acctName: data[index].trfAcctNameTh!=null?data[index].trfAcctNameTh:data[index].trfAcctNameEn,
                                        acctNo: data[index].trfAcctNo,
                                        amount: data[index].amount,
                                        bankName: data[index].bankName,
                                      )));
                        },
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  func.checkLogoBank(data[index].bankName),
                            ),
                            title: Text(
                              data[index].trfAcctNameTh!=null?
                              data[index].trfAcctNameTh:data[index].trfAcctNameEn,
                              style: TextStyle(fontSize: _height * 0.028),
                            ),
                            subtitle: Text(
                              'หมายเลขบัญชี: ' + data[index].trfAcctNo,
                              style: TextStyle(
                                  fontSize: _height * 0.024,
                                  color: Colors.grey),
                            ),
                            trailing: Wrap(
                              spacing: _height * 0.01,
                              children: <Widget>[
                                Text(
                                  '${formatMoney.format(data[index].amount)}',
                                  style: TextStyle(fontSize: _height * 0.024),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: backgroundMainColor,
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                        child: Container(
                          width: _width,
                          height: _height * 0.001,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
              )
            : Text('คุณยังไม่ได้เพิ่มผู้รับเงิน',
                style: TextStyle(fontSize: _height * 0.026)));
  }

  Widget _buildButtonSave(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return this.countAcct <= 10
        ? Padding(
            padding: EdgeInsets.only(
                left: _height * 0.02,
                right: _height * 0.02,
                bottom: _height * 0.01),
            child: InkWell(
              onTap: () => Navigator.of(context)
                  .popUntil(ModalRoute.withName(PageTo.selectGroupScreen)),
              child: Container(
                alignment: Alignment.center,
                width: _width,
                height: _height * 0.065,
                color: backgroundMainColor,
                child: Text(
                  'บันทึก',
                  style:
                      TextStyle(fontSize: _height * 0.03, color: Colors.white),
                ),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.only(
                left: _height * 0.02,
                right: _height * 0.02,
                bottom: _height * 0.01),
            child: Container(
              alignment: Alignment.center,
              width: _width,
              height: _height * 0.065,
              color: Colors.grey,
              child: Text(
                'บันทึก',
                style: TextStyle(fontSize: _height * 0.03, color: Colors.white),
              ),
            ),
          );
  }
}
