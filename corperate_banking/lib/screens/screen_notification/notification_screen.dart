import 'package:corperate_banking/global_function.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  FunctionGlobal func = FunctionGlobal();
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()=>func.onBackPressed(context),
          child: SafeArea(
            child: Scaffold(
          backgroundColor: Color(0xFFeaecf0),
          appBar: AppBar(
            leading: Container(),
            backgroundColor: Color(0xFF3b074b),
            centerTitle: true,
            title: Text(
              'การแจ้งเตือน',
              style: TextStyle(fontSize: _height * 0.03),
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(
              top: _height*0.01,
              left: _height*0.02,
              right: _height*0.02,
            ),
            height: _height,
            width: _width,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, int index) {
                return 
                Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          radius: _height*0.01,
                          backgroundColor: Color(0xFF7B2CBF),

                        ),
                      title: Text('รายการการโอนเงิน',style: TextStyle(
                        fontSize: _height*0.026
                      ),),
                      subtitle: Text('คุณได้โอนเงินจากบัญชีออมทรัพย์หมายเลขบัญชี 999-9-9999-9\nเข้าบัญชี 777-7-7777-7 เมื่อ 12 เม.ย. 2563 - 13:13\nยอดคงเหลือใช้ได้ 9000,000.00 บาท',style: TextStyle(
                        fontSize: _height*0.023

                      ),),
                    ),
                    Divider()
                    ],
                                  
                
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
