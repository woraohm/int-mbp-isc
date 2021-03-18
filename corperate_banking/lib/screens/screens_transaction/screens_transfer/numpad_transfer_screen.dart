import 'package:corperate_banking/pageTo.dart';

import 'package:corperate_banking/widgets/numpad_widget.dart';
import 'package:flutter/material.dart';

class NumpadScreen extends StatefulWidget {
  @override
  _NumpadScreenState createState() => _NumpadScreenState();
}

class _NumpadScreenState extends State<NumpadScreen> {
  int length = 6;

  onChange(String number) {
    if (number.length == length) {
      if (number == "123456") {
        Navigator.pushNamed(context, PageTo.transferSingleScreen);
      } else {
        number = null;
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration.zero,
            pageBuilder: (_, __, ___) => NumpadScreen(),
          ),
        );
      }
    }
    print(number);
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: _height*0.02,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios
                  ),
                ),
              ),
              Container(
            
                alignment: Alignment.center,
                height: _height*0.2,
                width: _width,
                child: Image.asset('assests/images/logo_isc_medium_purple.png',),

              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: Text(
                  'กรุณาใส่รหัส PIN',
                  style: TextStyle(
                    color: Colors.black,
                      fontSize: _height*0.03,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Numpad(length: length, onChange: onChange)
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildBackArrowIOSButton(double _height, double _width) {
  //   return Padding(
  //     padding: EdgeInsets.only(left: _height * 0.01),
  //     child: Container(
  //       alignment: Alignment.topLeft,
  //       width: _width * 0.1,
  //       height: _height,
  //       child: IconButton(
  //         icon: Icon(
  //           Icons.arrow_back_ios,
  //           color: Color(0xFF7B2CBF),
  //         ),
  //         onPressed: () => Navigator.pop(context),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildShowActionNumPad(double _height, double _width) {
  //   return Container(
  //     padding: EdgeInsets.only(left: _height*0.02, right: _height*0.02,top: _height*0.01),
  //     width: _width,
  //     height: _height * 0.1,
     
  //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: <Widget>[
  //       Card(
  //         elevation: 5,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(14)),
  //         child: Container(
  //           width: _width*0.12,
  //           height: _height
  //         ),
  //       ),
  //       Card(
  //         elevation: 5,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(14)),
  //         child: Container(
  //           width: _width*0.12,
  //           height: _height,
  //         ),
  //       ),
  //       Card(
  //         elevation: 5,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(14)),
  //         child: Container(
  //           width: _width*0.12,
  //           height: _height,
  //         ),
  //       ),
  //       Card(
  //         elevation: 5,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(14)),
  //         child: Container(
  //           width: _width*0.12,
  //           height: _height,
  //         ),
  //       ),
  //       Card(
  //         elevation: 5,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(14)),
  //         child: Container(
  //           width: _width*0.12,
  //           height: _height,
  //         ),
  //       ),
  //       Card(
  //         elevation: 5,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(14)),
  //         child: Container(
  //           width: _width*0.12,
  //           height: _height,
  //         ),
  //       ),
  //     ],),

  //   );
  // }

  // Widget _buildLogo(double _height, double _width) {
  //   return Container(
  //     padding: EdgeInsets.all(_height * 0.02),
  //     width: _width,
  //     height: _height,
  //     child: Image.asset('assests/images/logo_isc_medium_pink.png'),
  //   );
  // }

  // Widget _buildInputNumPad(double _height, double _width){
  //   return Padding(
  //     padding: EdgeInsets.only(left: _height*0.02, right: _height*0.02),
  //     child: Container(
  //       //color: Colors.green,
  //       width: _width,
  //       height: _height*0.6,
  //       child: Column(children: <Widget>[
  //         Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           _buildButtonNumpad(_height, _width, '1'),
  //           _buildButtonNumpad(_height, _width, '2'),
  //           _buildButtonNumpad(_height, _width, '3'),
  //         ],
  //         ),
  //         SizedBox(height: _height*0.02,),
  //         Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           _buildButtonNumpad(_height, _width, '4'),
  //           _buildButtonNumpad(_height, _width, '5'),
  //           _buildButtonNumpad(_height, _width, '6'),
  //         ],
  //         ),
  //         SizedBox(height: _height*0.02,),
  //         Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           _buildButtonNumpad(_height, _width, '7'),
  //           _buildButtonNumpad(_height, _width, '8'),
  //           _buildButtonNumpad(_height, _width, '9'),
  //         ],
  //         ),
  //         SizedBox(height: _height*0.02,),
  //         Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           _buildButtonNumpad(_height, _width, ''),
  //           _buildButtonNumpad(_height, _width, '0'),
  //           _buildButtonNumpad(_height, _width, 'delete'),
  //         ],
  //         ),
  //         SizedBox(height: _height*0.02,),
  //       ],),
        
  //     ),
  //   );
  // }
  // Widget _buildButtonNumpad(double _height, double _width, String num){
  //   return Container(
  //     alignment: Alignment.center,
  //     width: _width*0.2,
  //     height: _height*0.1,
  //     decoration: num==''?BoxDecoration(
  //       shape: BoxShape.circle,
  //     ):BoxDecoration(
  //       shape: BoxShape.circle,
  //       border: Border.all(color: Color(0xFF7B2CBF))
  //     ),
  //     child: Text(num,style: TextStyle(fontSize: _height*0.04),),
  //   );
  // }
}
