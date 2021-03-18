import 'dart:convert';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rest_package/bean/add_account_to_group_request.dart';
import 'package:rest_package/bean/add_account_to_group_response.dart';
import 'package:rest_package/bean/select_member_to_group_request.dart';
import 'package:rest_package/bean/select_member_to_group_response.dart';
import 'package:rest_package/connection/add_account_to_group_connection.dart';

import 'package:rest_package/connection/select_member_to_group_connection.dart';

import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/model/select_account_to_add_group_list_model.dart';

import 'package:rest_package/model/select_member_to_group_model_response.dart';

class AddAccountToGroupScreen extends StatefulWidget {
  String groupName;
  AddAccountToGroupScreen({this.groupName});
  @override
  _AddAccountToGroupScreenState createState() =>
      _AddAccountToGroupScreenState(groupName: groupName);
}

class _AddAccountToGroupScreenState extends State<AddAccountToGroupScreen> {
  String groupName;
  _AddAccountToGroupScreenState({this.groupName});
  FunctionGlobal func = FunctionGlobal();
  XSignature randReqRefNo = XSignature();
  SelectMemberToGroupConnection selectMemberConnect =
      SelectMemberToGroupConnection(globals.iPV4, '8080');
  AddAccountToGroupConnection addAccountToGroupConnect =
      AddAccountToGroupConnection(globals.iPV4, '8080');
  TextEditingController amountController = TextEditingController();
  bool select = false;
  List<bool> selects = [];
  List<SelectAccountToAddGroupModel> userList = [];

  Future<List<SelectMemberToGroupModelResponse>> getListToAddGroup() async {
    List<SelectMemberToGroupModelResponse> getListToAddGroupList = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNogetListToAddGroup: ' + reqRefNo);
    SelectMemberToGroupRequest request = SelectMemberToGroupRequest(
        reqRefNo: reqRefNo, groupName: this.groupName);
    await selectMemberConnect
        .selectMemberToGroupConnection(request, globals.token)
        .then((value) {
      //print('status code getListToAddGroup= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        SelectMemberToGroupResponse response =
            SelectMemberToGroupResponse.fromJson(responseMap);
        print("respDescgetListToAddGroup: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (SelectMemberToGroupModelResponse data in response.listAcctNo) {
            getListToAddGroupList.add(data);
          }
        }
      }
    });

    return getListToAddGroupList;
  }

  Future<void> addAccountToGroupNow() async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNoaddAccountToGroupNow: ' + reqRefNo);
    AddAccountToGroupRequest request = AddAccountToGroupRequest(
        reqRefNo: reqRefNo,
        groupName: this.groupName,
        listAddAccountGroupRequest: this.userList);
    await addAccountToGroupConnect
        .connectAddAccountToGroup(request, globals.token)
        .then((value) {
      //print('status code addAccountToGroupNow= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        AddAccountToGroupResponse response =
            AddAccountToGroupResponse.fromJson(responseMap);
        print("respDescaddAccountToGroupNow: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          print("add group success");
          showSuccessToast() {
            Fluttertoast.showToast(
                msg: "เพิ่มไปยังกลุ่มสำเร็จ",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.blueAccent,
                textColor: Colors.white,
                fontSize: 16.0);
          }

          Navigator.pop(context);
        }
        showSuccessToast() {
          Fluttertoast.showToast(
              msg: "กรุณาลองใหม่อีกครั้ง",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        Navigator.pop(context);
      }
    });
  }

  @override
  void intState() {
    userList.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[
            InkWell(
              onTap: () {
                addAccountToGroupNow();
                // Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(
                    right: _height * 0.02, left: _height * 0.02),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'ต่อไป',
                      style: TextStyle(fontSize: _height * 0.03),
                    )),
              ),
            )
          ],
          centerTitle: true,
          title: Text(
            'เลือกบัญชี',
            style: TextStyle(fontSize: _height * 0.03),
          ),
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: _height * 0.02,
                  right: _height * 0.02,
                  top: _height * 0.01),
              width: _width,
              height: _height,
              child: _buildData(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildData(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<SelectMemberToGroupModelResponse>>(
      future: getListToAddGroup(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var data = snapshot.data;

          int lengthData = data.length;
          for (int i = 0; i < lengthData; i++) {
            this.selects.add(false);
          }
          return ListView.builder(
            itemCount: lengthData,
            itemBuilder: (context, int index) {
              return Column(children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.only(
                        left: _height * 0.02,
                        //right: _height * 0.02,
                        top: _height * 0.01),
                    width: _width,
                    height: _height * 0.12,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: _width * 0.15,
                          height: _height,
                          child: CircleAvatar(
                            backgroundImage:
                                func.checkLogoBank(data[index].bankName),
                          ),
                        ),
                        Container(
                          width: _width * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                data[index].acctName,
                                style: TextStyle(fontSize: _height * 0.028),
                              ),
                              Text(
                                'หมายเลขบัญชี ' + data[index].acctNo,
                                style: TextStyle(
                                    fontSize: _height * 0.024,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        this.selects[index] == false
                            ? InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          elevation: 5,
                                          backgroundColor: backgroundColor,
                                          content: Container(
                                            height: _height * 0.3,
                                            width: _width,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundImage:
                                                        func.checkLogoBank(
                                                            data[index]
                                                                .bankName),
                                                  ),
                                                  title: Text(
                                                    data[index].acctName,
                                                    style: TextStyle(
                                                        fontSize:
                                                            _height * 0.025),
                                                  ),
                                                  subtitle: Text(
                                                    data[index].acctNo,
                                                    style: TextStyle(
                                                        fontSize:
                                                            _height * 0.024),
                                                  ),
                                                ),
                                                Text(
                                                  'จำนวนเงิน',
                                                  style: TextStyle(
                                                      fontSize:
                                                          _height * 0.024),
                                                ),
                                                TextFormField(
                                                  controller: amountController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                      fontSize:
                                                          _height * 0.024),
                                                ),
                                                SizedBox(
                                                  height: _height * 0.02,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      this.selects[index] =
                                                          true;
                                                    });

                                                    userList.add(SelectAccountToAddGroupModel(
                                                        bank_Name_Recipient:
                                                            data[index]
                                                                .bankName,
                                                        recipient_account_No:
                                                            data[index].acctNo,
                                                        recipient_account_No_name_Th:
                                                            data[index]
                                                                .acctName,
                                                        transAmount:
                                                            double.parse(
                                                                amountController
                                                                    .text)));
                                                    for (var data in userList) {
                                                      print('คุณคนนี้อยู่ในลิส ' +
                                                          data.recipient_account_No_name_Th);
                                                    }

                                                    Navigator.pop(context);
                                                  },
                                                  child: Card(
                                                    color: backgroundMainColor,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: _width,
                                                      height: _height * 0.06,
                                                      child: Text(
                                                        'บันทึก',
                                                        style: TextStyle(
                                                            fontSize:
                                                                _height * 0.025,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: _width * 0.2,
                                  height: _height * 0.07,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: backgroundMainColor),
                                  child: Text(
                                    'เพิ่ม',
                                    style: TextStyle(
                                        fontSize: _height * 0.023,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  userList.removeAt(index);
                                  setState(() {
                                    this.selects[index] = false;
                                  });
                                  for (var data in userList) {
                                    print('คุณคนนี้อยู่ในลิส ' +
                                        data.recipient_account_No_name_Th);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: _width * 0.2,
                                  height: _height * 0.07,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Colors.red),
                                  child: Text(
                                    'ยกเลิก',
                                    style: TextStyle(
                                        fontSize: _height * 0.023,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                )
              ]);
            },
          );
        }
      },
    );
  }
}

class AccountUser {
  String acctName;
  String acctNo;
  String bankName;
  double amount;
  bool ischeck;

  AccountUser(
      {this.acctName, this.acctNo, this.bankName, this.ischeck, this.amount});
}
