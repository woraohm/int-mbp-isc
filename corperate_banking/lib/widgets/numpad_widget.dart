import 'package:flutter/material.dart';

class Numpad extends StatefulWidget {
  final int length;
  final Function onChange;
  Numpad({Key key, this.length, this.onChange}) : super(key: key);

  @override
  _NumpadState createState() => _NumpadState();
}

class _NumpadState extends State<Numpad> {
  String number = '';

  setValue(String val){
    if(number.length < widget.length)
      setState(() {
        number += val;
        widget.onChange(number);
      });
  }

  backspace(String text){
    if(text.length > 0){
      setState(() {
        number = text.split('').sublist(0,text.length-1).join('');
        widget.onChange(number);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
  
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _height*0.02),
      child: Column(
     
        children: <Widget>[
          Preview(text: number, length: widget.length),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '1',
                onPressed: ()=>setValue('1'),
              ),
              NumpadButton(
                text: '2',
                onPressed: ()=>setValue('2'),
              ),
              NumpadButton(
                text: '3',
                onPressed: ()=>setValue('3'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '4',
                onPressed: ()=>setValue('4'),
              ),
              NumpadButton(
                text: '5',
                onPressed: ()=>setValue('5'),
              ),
              NumpadButton(
                text: '6',
                onPressed: ()=>setValue('6'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '7',
                onPressed: ()=>setValue('7'),
              ),
              NumpadButton(
                text: '8',
                onPressed: ()=>setValue('8'),
              ),
              NumpadButton(
                text: '9',
                onPressed: ()=>setValue('9'),
              ),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                  haveBorder: false
              ),
              NumpadButton(
                text: '0',
                onPressed: ()=>setValue('0'),
              ),
             
              NumpadButton(
                haveBorder: false,
                icon: Icons.backspace,
                onPressed: ()=>backspace(number),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Preview extends StatelessWidget {
  final int length;
  final String text;
  const Preview({Key key, this.length, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;

    List<Widget> previewLength = [];
    for (var i = 0; i < length; i++) {
      previewLength.add(Dot(isActive: text.length >= i+1));
    }
    return Container(
        padding: EdgeInsets.symmetric(vertical: _height*0.001),
        child: Wrap(
            children: previewLength
        )
    );
  }
}

class Dot extends StatelessWidget {
  final bool isActive;
  const Dot({Key key, this.isActive = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(_height*0.01),
      child: Container(
        width: _height*0.02,
        height: _height*0.02,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
          border: Border.all(
              width: _width*0.001,
              color: Theme.of(context).primaryColor
          ),
          borderRadius: BorderRadius.circular(_height*0.1),
        ),
      ),
    );
  }
}

class NumpadButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool haveBorder;
  final Function onPressed;
  const NumpadButton({Key key, this.text, this.icon, this.haveBorder=true, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    
    TextStyle buttonStyle = TextStyle(
        fontSize: _height*0.03,
        color: Theme.of(context).primaryColor);
    Widget label = icon != null ? Icon(icon, color: Theme.of(context).primaryColor.withOpacity(1), size: _height*0.03,)
        : Text(this.text ?? '', style: buttonStyle);

    return Container(
      padding: EdgeInsets.symmetric(vertical: _height*0.01),
      child: OutlineButton(
        borderSide: haveBorder ? BorderSide(
            color: Colors.grey[400]
        ) : BorderSide.none ,
        highlightedBorderColor: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.3),
        splashColor: icon!=null ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
        padding: EdgeInsets.all(_height*0.04),
        shape: CircleBorder(),
        onPressed: onPressed,
        child: label,
      ),
    );
  }
}