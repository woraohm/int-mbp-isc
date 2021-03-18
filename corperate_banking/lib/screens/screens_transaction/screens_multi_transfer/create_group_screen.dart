import 'dart:convert';
import 'dart:ffi';

import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/manage_group_recipient_screen.dart';

import 'package:flutter/material.dart';
import 'package:rest_package/bean/create_group_request.dart';
import 'package:rest_package/bean/create_group_response.dart';
import 'package:rest_package/connection/create_group_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:rflutter_alert/rflutter_alert.dart';

class CreateGroupMultiTransferScreen extends StatefulWidget {
  @override
  _CreateGroupMultiTransferScreenState createState() =>
      _CreateGroupMultiTransferScreenState();
}

class _CreateGroupMultiTransferScreenState
    extends State<CreateGroupMultiTransferScreen> {
  FunctionGlobal func = FunctionGlobal();
  TextEditingController nameGroupController = TextEditingController();
  XSignature randReqRefNo = XSignature();
  String checkText = '';
  CreateGroupConnection createGroupConnect =
      CreateGroupConnection(globals.iPV4, '8080');

  Future<Void> createGroup(String groupName) async {
    List<CreateGroupResponse> createGroupList = [];
    String reqRefNo = "REQ" + randReqRefNo.generateREQRefNo();
    //print('reqRefNocreateGroup: ' + reqRefNo);
    CreateGroupRequest request =
        CreateGroupRequest(reqRefNo: reqRefNo, groupName: groupName);
    await createGroupConnect
        .connectCreateGroup(request, globals.token)
        .then((value) {
      //print('status code createGroup= ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        //print('body: ' + value.body);
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        CreateGroupResponse response =
            CreateGroupResponse.fromJson(responseMap);
        print("respDesccreateGroup: " + response.respDesc);
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ManageGroupRecipientScreen(
                        groupName: groupName,
                      )));
        } else {
          func.showAlert(context, response.message);
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
        appBar: func.buildAppBar(context, 'สร้างกลุ่มผู้รับเงิน'),
        backgroundColor: backgroundColor,
        body: Stack(
          children: <Widget>[
            Container(
              width: _width,
              height: _height * 0.16,
              child: _buildCreateGroup(context),
            ),
            Container(
                padding: EdgeInsets.only(
                    left: _height * 0.02,
                    right: _height * 0.02,
                    bottom: _height * 0.02),
                alignment: Alignment.bottomCenter,
                width: _width,
                height: _height,
                child: _buildCreateButton(context))
          ],
        ),
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return checkText.length == 0
        ? InkWell(
            onTap: () {},
            child: Card(
              color: Colors.grey,
              child: Container(
                alignment: Alignment.center,
                width: _width,
                height: _height * 0.08,
                child: Text(
                  'สร้างกลุ่มผู้รับเงิน',
                  style:
                      TextStyle(fontSize: _height * 0.03, color: Colors.white),
                ),
              ),
            ),
          )
        : InkWell(
            onTap: () {
              createGroup(nameGroupController.text);
            },
            child: Card(
              color: backgroundMainColor,
              child: Container(
                alignment: Alignment.center,
                width: _width,
                height: _height * 0.08,
                child: Text(
                  'สร้างกลุ่มผู้รับเงิน',
                  style:
                      TextStyle(fontSize: _height * 0.03, color: Colors.white),
                ),
              ),
            ),
          );
  }

  Widget _buildCreateGroup(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
          left: _height * 0.02, right: _height * 0.02, top: _height * 0.01),
      width: _width,
      height: _height,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ชื่อกลุ่ม',
            style: TextStyle(
                fontSize: _height * 0.028, fontWeight: FontWeight.w600),
          ),
          Container(
            width: _width,
            height: _height * 0.08,
            child: TextFormField(
              controller: nameGroupController,
              onChanged: (value) {
                setState(() {
                  checkText = value;
                });
              },
              maxLength: 20,
              style: TextStyle(
                fontSize: _height * 0.024,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: _height * 0.024),
                hintText: 'ตั้งชื่อกลุ่ม',
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
