import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:corperate_banking/pageTo.dart';
import 'package:corperate_banking/screens/accounts_screen.dart';
import 'package:corperate_banking/screens/home_screen.dart';
import 'package:corperate_banking/screens/screen_notification/notification_screen.dart';
import 'package:corperate_banking/screens/screens_order/order_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/transaction_screen.dart';
import 'package:corperate_banking/screens/setting_screen.dart';
import 'package:badges/badges.dart';
import 'package:corperate_banking/global/global.dart' as globals;

import 'package:flutter/material.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int currentIndex = 0;

  
  List pages = [
    AccountsScreen(),
    OrderScreen(),

    NotificationScreen(),
    SettingScreen()
  ];

  

  
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: bottomNavBar(context, _height),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            
        floatingActionButton: FloatingActionButton(
          elevation: 5,
          mini: false,
          onPressed: () =>
              Navigator.pushNamed(context, PageTo.transactionScreen),
          child: Icon(
            Icons.attach_money,
            size: _height * 0.05,
            color: Colors.white
          ),
          // child: Image.asset('assests/images/thailand-baht.png',scale: _height*0.015,),
          backgroundColor: Color(0xFF3b074b),
        ),
      ),
    );
  }

  Widget bottomNavBarConvex(BuildContext context, double _height) {
    return ConvexAppBar(
      style: TabStyle.fixed,
      top: -_height * 0.03,
      curveSize: _height * 0.09,
      backgroundColor: Colors.pink[300],
      height: _height / 14,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        TabItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            title: 'หน้าหลัก'),
        TabItem(
            icon: Icon(
              Icons.assignment,
              color: Colors.white,
            ),
            title: 'รายการ'),
        TabItem(
            icon: Icon(
              Icons.monetization_on,
              size: _height * 0.055,
              color: Colors.white,
            ),
            title: 'ธุรกรรม'),
        TabItem(
            icon: Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
            title: 'การแจ้งเตือน'),
        TabItem(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: 'ตั้งค่า'),
      ],
    );
  }

  Widget _buildTextHome(BuildContext context, double _height) {
    return Text('aaaa');
  }

  Widget bottomNavBar(BuildContext context, double _height) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF3b074b),
      unselectedItemColor: Color(0xFF949698),
      showUnselectedLabels: true,
      iconSize: _height * 0.03,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          // ignore: deprecated_member_use
          title: Text(
            'หน้าหลัก',
            style: TextStyle(
                fontSize: _height * 0.023, fontWeight: FontWeight.w300),
          ),
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
            ),
            // ignore: deprecated_member_use
            title: Text(
              'รายการ',
              style: TextStyle(
                  fontSize: _height * 0.023, fontWeight: FontWeight.w300),
            )),
        
        BottomNavigationBarItem(
            icon: Badge(
              child: Icon(
                Icons.notifications_active,
              ),
            ),
            // ignore: deprecated_member_use
            title: Text(
              'การแจ้งเตือน',
              style: TextStyle(
                  fontSize: _height * 0.023, fontWeight: FontWeight.w300),
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            // ignore: deprecated_member_use
            title: Text(
              'ตั้งค่า',
              style: TextStyle(
                  fontSize: _height * 0.023, fontWeight: FontWeight.w300),
            )),
      ],
    );
  }
}

class Style extends StyleHook {
  @override
  // TODO: implement activeIconMargin
  double get activeIconMargin => 40;

  @override
  // TODO: implement activeIconSize
  double get activeIconSize => 60;

  @override
  // TODO: implement iconSize
  double get iconSize => 30;

  @override
  TextStyle textStyle(Color color) {
    // TODO: implement textStyle
    return TextStyle(fontSize: 20, color: Colors.white);
  }
}
