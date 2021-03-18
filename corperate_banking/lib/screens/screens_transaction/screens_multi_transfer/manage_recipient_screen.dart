import 'package:corperate_banking/global_function.dart';
import 'package:flutter/material.dart';

class ManageRecipientScreen extends StatefulWidget {
  String bankName;
  String acctNo;
  String acctName;
  double amount;
  ManageRecipientScreen(
      {this.amount, this.acctName, this.acctNo, this.bankName});
  @override
  _ManageRecipientScreenState createState() => _ManageRecipientScreenState(
      acctName: acctName, acctNo: acctNo, amount: amount, bankName: bankName);
}

class _ManageRecipientScreenState extends State<ManageRecipientScreen> {
  String bankName;
  String acctNo;
  String acctName;
  double amount;
  _ManageRecipientScreenState(
      {this.amount, this.acctName, this.acctNo, this.bankName});
  FunctionGlobal func = FunctionGlobal();
  TextEditingController editAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //editAmountController.text=amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        appBar: func.buildAppBar(context, 'แก้ไขข้อมูลผู้รับเงิน'),
        body: Container(
          width: _width,
          height: _height,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: _height * 0.02, top: _height * 0.01),
                    child: Text(
                      'ไปยัง',
                      style: TextStyle(
                          fontSize: _height * 0.024, color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.01,
                  ),
                  Container(
                    color: Colors.white,
                    width: _width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: _height * 0.02, right: _height * 0.02),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: _height * 0.04,
                              backgroundImage: func.checkLogoBank(bankName),
                            ),
                            title: Text(
                              bankName,
                              style: TextStyle(fontSize: _height * 0.028),
                            ),
                            subtitle: Text(
                              acctNo,
                              style: TextStyle(fontSize: _height * 0.024),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.02,
                        ),
                        SizedBox(
                          child: Container(
                            height: _height * 0.001,
                            color: Colors.grey[300],
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: _height * 0.02, right: _height * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ชื่อบัญชี',
                                style: TextStyle(fontSize: _height * 0.028),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: _height * 0.02),
                                alignment: Alignment.centerLeft,
                                width: _width,
                                height: _height * 0.05,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text(
                                  acctName,
                                  style: TextStyle(
                                      fontSize: _height * 0.024,
                                      color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.04,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: _height * 0.02, top: _height * 0.01),
                    child: Text(
                      'จำนวนเงิน',
                      style: TextStyle(
                          fontSize: _height * 0.024, color: Colors.grey),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: _height * 0.02, right: _height * 0.02),
                    alignment: Alignment.bottomCenter,
                    width: _width,
                    height: _height * 0.1,
                    color: Colors.white,
                    child: TextFormField(
                      controller: editAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: amount.toString()),
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: _height * 0.04),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: _height * 0.02, right: _height * 0.02),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        alignment: Alignment.center,
                        width: _width,
                        height: _height * 0.07,
                        color: backgroundMainColor,
                        child: Text(
                          'บันทึก',
                          style: TextStyle(
                              fontSize: _height * 0.028, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
