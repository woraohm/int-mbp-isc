import 'dart:convert';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/second_screen_view_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:rest_package/bean/delete_group_request.dart';
import 'package:rest_package/bean/delete_group_response.dart';
import 'package:rest_package/bean/select_group_request.dart';
import 'package:rest_package/bean/select_group_response.dart';
import 'package:rest_package/connection/delete_group_connection.dart';
import 'package:rest_package/connection/select_group_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rest_package/model/select_group_model_response.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SelectGroup extends StatefulWidget {
  @override
  _SelectGroupState createState() => _SelectGroupState();
}



class _SelectGroupState extends State<SelectGroup> {
  int checkLengthData = 0;
  XSignature randReqRefNo = XSignature();
  SelectGroupConnection selectGroupConnect =
      SelectGroupConnection(globals.iPV4, '8080');
  DeleteGroupConnection deleteGroupConnect = DeleteGroupConnection(globals.iPV4, '8080');
  final formatMoney = new NumberFormat("#,##0.00", "en_US");
  FunctionGlobal func = FunctionGlobal();
  void refreshData() {
    groupNameList();
  }

  onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }
  Future<List<SelectGroupModelResponse>> groupNameList() async {
    List<SelectGroupModelResponse> groupNameListList = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNogroupNameList: ' + reqRefNo);
    SelectGroupRequest request = SelectGroupRequest(reqRefNo: reqRefNo);
    await selectGroupConnect
        .selectGroupConnection(request, globals.token)
        .then((value) {
      //print('status code groupNameList= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        SelectGroupResponse response =
            SelectGroupResponse.fromJson(responseMap);
        print("respDescgroupNameList: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          for (SelectGroupModelResponse data in response.listGroup) {
            groupNameListList.add(data);
          }
          this.checkLengthData = response.lenghtList;
        }
      }
    });

    // print(this.checkLengthData);

    return groupNameListList;
  }
  Future<void> deleteGroup(String groupName) async {
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNodeleteGroup: ' + reqRefNo);
    DeleteGroupRequest request = DeleteGroupRequest(reqRefNo: reqRefNo,groupName: groupName);
    await deleteGroupConnect
        .connectDeleteGroup(request, globals.token)
        .then((value) {
      //print('status code deleteGroup= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        DeleteGroupResponse response = DeleteGroupResponse.fromJson(responseMap);

        print("respDescdeleteGroup: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "ลบบัญชีกลุ่มสำเร็จ",
              textStyle: TextStyle(fontSize: 20),
            ),
          );
          setState(() {
            groupNameList();
          });
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: func.buildAppBar(context, 'โอนหลายรายการ'),
        body: FutureBuilder<List<SelectGroupModelResponse>>(
            future: groupNameList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var data = snapshot.data;
                int lengthData = data.length;
                return Stack(
                  children: [
                    Container(
                        width: _width,
                        height: _height * 0.7,
                        child: lengthData == 0
                            ? _buildHasNodata(context)
                            : _buildHasData(context, data, lengthData)),
                    Container(
                      width: _width,
                      height: _height,
                      child: _buildCreateGroupButton(context),
                    )
                  ],
                );
              }
            }),
      ),
    );
  }

  Widget _buildHasNodata(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Center(
        child: Container(
      width: _width * 0.8,
      height: _height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset('assests/images/solutions-credit-transfer.png'),
          ),
          SizedBox(
            height: _height * 0.05,
          ),
          Text('คุณยังไม่ได้สร้างกลุ่มผู้รับเงิน',
              style: TextStyle(fontSize: _height * 0.026))
        ],
      ),
    ));
  }


  

  Widget _buildHasData(BuildContext context,
      List<SelectGroupModelResponse> data, int lengthData) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: lengthData,
      itemBuilder: (context, int index) {
        return Slidable(
          actionPane: SlidableScrollActionPane(),
          secondaryActions: [
            IconSlideAction(
              caption: 'Delete',
              icon: Icons.delete,
              color: Color(0xFF3b074b),
              onTap: () {
                deleteGroup(data[index].nameGroup);
              },
            )
          ],
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewGroupScreen(
                                groupName: data[index].nameGroup,
                              ))).then(onGoBack);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: _height * 0.02,
                      right: _height * 0.02,
                      top: _height * 0.01),
                  width: _width,
                  height: _height * 0.12,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data[index].nameGroup,
                        style: TextStyle(fontSize: _height * 0.028),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          width: _width,
                          height: _height * 0.03,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                data[index].totalAmount != null
                                    ? '${formatMoney.format(data[index].totalAmount)}'
                                    : '',
                                style: TextStyle(fontSize: _height * 0.028),
                              ),
                              SizedBox(
                                width: _height * 0.01,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: backgroundMainColor,
                              )
                            ],
                          )),
                      Text(
                        'จำนวนผู้รับเงิน: ' +
                            data[index].countRecipient.toString(),
                        style: TextStyle(
                            fontSize: _height * 0.024, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.001,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildCreateGroupButton(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          left: _height * 0.02, right: _height * 0.02, bottom: _height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('สามารถมีกลุ่มผู้รับเงินได้สูงสุด 10 กลุ่ม',
              style: TextStyle(fontSize: _height * 0.024)),
          SizedBox(
            height: _height * 0.03,
          ),
          this.checkLengthData >= 10
              ? Card(
                  color: Colors.grey,
                  child: Container(
                    alignment: Alignment.center,
                    width: _width,
                    height: _height * 0.08,
                    child: Text(
                      'สร้างกลุ่มผู้รับเงิน',
                      style: TextStyle(
                          fontSize: _height * 0.03, color: Colors.white),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, PageTo.createGroupMultiTransfer),
                  child: Card(
                    color: backgroundMainColor,
                    child: Container(
                      alignment: Alignment.center,
                      width: _width,
                      height: _height * 0.08,
                      child: Text(
                        'สร้างกลุ่มผู้รับเงิน',
                        style: TextStyle(
                            fontSize: _height * 0.03, color: Colors.white),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
