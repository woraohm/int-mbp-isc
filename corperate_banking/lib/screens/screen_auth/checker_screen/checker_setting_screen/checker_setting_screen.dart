import 'dart:convert';
import 'dart:ui';
import 'package:corperate_banking/global/global.dart' as globals;
import 'package:corperate_banking/global_function.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:flutter/material.dart';
import 'package:rest_package/bean/logout_request.dart';
import 'package:rest_package/bean/logout_response.dart';
import 'package:rest_package/connection/logout_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
class CheckerSettingScreen extends StatefulWidget {
  @override
  _CheckerSettingScreenState createState() => _CheckerSettingScreenState();
}

class _CheckerSettingScreenState extends State<CheckerSettingScreen> {
  FunctionGlobal func = FunctionGlobal();
  XSignature randReqRefNo = XSignature();
  LogoutConnection logout = LogoutConnection('192.168.253.59', '8080');
  
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, _height),
        body: Stack(
          children: <Widget>[
            _buildBackgroundImageBlur(context),
            Container(
              height: _height,
              width: _width,
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _buildHeader(context),
                      Container(
                        width: _width,
                        alignment: Alignment.bottomRight,
                        child: Container(
                            padding: EdgeInsets.only(
                                left: _height * 0.01, right: _height * 0.01),
                            color: Colors.white,
                            child: Text(
                              'ข้อมูลส่วนตัว',
                              style: TextStyle(
                                  fontSize: _height * 0.024,
                                  color: Color(0xFF3b074b)),
                            )),
                      ),
                      Container(
                        width: _width,
                        height: _height * 0.005,
                        color: Colors.white,
                      ),
                      _buildEmail(context),
                      Divider(
                        height: _height * 0.002,
                        color: Colors.white,
                      ),
                      _buildPhone(context),
                      Divider(
                        height: _height * 0.002,
                        color: Colors.white,
                      ),
                      _buildCompany(context),
                      Divider(
                        height: _height * 0.002,
                        color: Colors.white,
                      ),
                      SizedBox(height: _height*0.1,),
                      _buildButtonSignOut(context)
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
  Widget _buildCompany(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: _height * 0.02,
        right: _height * 0.02,
      ),
      child: Container(
        alignment: Alignment.center,
        width: _width,
        height: _height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: _height,
              child: Wrap(
                spacing: _height * 0.01,
                children: <Widget>[
                  Icon(
                    Icons.apartment,
                    size: _height * 0.03,
                    color: Color(0xFF3b074b),
                  ),
                  Text(
                    'บริษัท:',
                    style: TextStyle(
                        fontSize: _height * 0.024, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Text(
              globals.nameTHCompany,
              style: TextStyle(
                  fontSize: _height * 0.024, fontWeight: FontWeight.w500),
            )
            // Container(

            //   color: Colors.white,
            //   child: Text(
            //       'อีเมลล์:',
            //       style: TextStyle(
            //           fontSize: _height * 0.024, fontWeight: FontWeight.w500),
            //     ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildPhone(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: _height * 0.02,
        right: _height * 0.02,
      ),
      child: Container(
        alignment: Alignment.center,
        width: _width,
        height: _height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: _height,
              child: Wrap(
                spacing: _height * 0.01,
                children: <Widget>[
                  Icon(
                    Icons.phone,
                    size: _height * 0.03,
                    color: Color(0xFF3b074b),
                  ),
                  Text(
                    'เบอรืโทรศัพท์:',
                    style: TextStyle(
                        fontSize: _height * 0.024, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Text(
              globals.staffMobile,
              style: TextStyle(
                  fontSize: _height * 0.024, fontWeight: FontWeight.w500),
            )
            // Container(

            //   color: Colors.white,
            //   child: Text(
            //       'อีเมลล์:',
            //       style: TextStyle(
            //           fontSize: _height * 0.024, fontWeight: FontWeight.w500),
            //     ),
            // )
          ],
        ),
      ),
    );
  }


  Widget _buildButtonSignOut(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(_height * 0.015),
      height: _height * 0.1,
      width: _width,
      child: InkWell(
        onTap: ()=>func.logOut(context),
          child: Container(
          alignment: Alignment.center,
          height: _height,
          width: _width,
          decoration: BoxDecoration(
              color: Color(0xFF3b074b), borderRadius: BorderRadius.circular(20)),
          child: Text(
            'ออกจากระบบ',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: _height * 0.026,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: _height * 0.02,
        right: _height * 0.02,
      ),
      child: Container(
        alignment: Alignment.center,
        width: _width,
        height: _height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: _height,
              child: Wrap(
                spacing: _height * 0.01,
                children: <Widget>[
                  Icon(
                    Icons.mail,
                    size: _height * 0.03,
                    color: Color(0xFF3b074b)
                  ),
                  Text(
                    'อีเมลล์:',
                    style: TextStyle(
                        fontSize: _height * 0.024, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Text(
              globals.staffEmail,
              style: TextStyle(
                  fontSize: _height * 0.024, fontWeight: FontWeight.w500),
            )
            // Container(

            //   color: Colors.white,
            //   child: Text(
            //       'อีเมลล์:',
            //       style: TextStyle(
            //           fontSize: _height * 0.024, fontWeight: FontWeight.w500),
            //     ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          left: _height * 0.03, right: _height * 0.03, top: _height * 0.02),
      child: Container(
          height: _height * 0.2,
          width: _width,
          child: Column(
            children: <Widget>[
              Container(
                width: _width,
                height: _height * 0.2,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: _width,
                      height: _height * 0.1,
                      child: CircleAvatar(
                        radius: _height * 0.05,
                        backgroundImage:
                            AssetImage('assests/images/avatar-circle.png'),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        globals.staffFname + ' ' + globals.staffLname,
                        style: TextStyle(
                            fontSize: _height * 0.024,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'สถานะ ' + globals.staffThem,
                        style: TextStyle(
                            fontSize: _height * 0.024,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
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

  Widget _buildAppBar(
    BuildContext context,
    double _height,
  ) {
    return AppBar(
        backgroundColor: Color(0xFF3b074b),
        centerTitle: true,
        leading: func.appBarPop(context),
        title: Text(
          'การตั้งค่า',
          style: TextStyle(fontSize: _height * 0.03),
        ));
  }
}