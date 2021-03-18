import 'package:corperate_banking/global_function.dart';
import 'package:flutter/material.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:corperate_banking/global/global.dart' as globals;
XSignature randReqRefNo = XSignature();
FunctionGlobal func = FunctionGlobal();


List<dynamic> _generatePDFData() {
    return [
      {"วันที่":"01/01/21", "เวลา": "12.12", "เลขที่รายการ": "1234567890", "ยอดเงินคงเหลือ":"1000.00", "รายละเอียด":"โอนเงินบุคคลอื่น นายตัวอย่าง ตัวอย่าง"},
      {"วันที่":"01/01/21", "เวลา": "12.12", "เลขที่รายการ": "1234567890", "ยอดเงินคงเหลือ":"1000.00", "รายละเอียด":"โอนเงินบุคคลอื่น นายตัวอย่าง ตัวอย่าง"},
      {"วันที่":"01/01/21", "เวลา": "12.12", "เลขที่รายการ": "1234567890", "ยอดเงินคงเหลือ":"1000.00", "รายละเอียด":"โอนเงินบุคคลอื่น นายตัวอย่าง ตัวอย่าง"},
      {"วันที่":"01/01/21", "เวลา": "12.12", "เลขที่รายการ": "1234567890", "ยอดเงินคงเหลือ":"1000.00", "รายละเอียด":"โอนเงินบุคคลอื่น นายตัวอย่าง ตัวอย่าง"},
      {"วันที่":"01/01/21", "เวลา": "12.12", "เลขที่รายการ": "1234567890", "ยอดเงินคงเหลือ":"1000.00", "รายละเอียด":"โอนเงินบุคคลอื่น นายตัวอย่าง ตัวอย่าง"},
      {"วันที่":"01/01/21", "เวลา": "12.12", "เลขที่รายการ": "1234567890", "ยอดเงินคงเหลือ":"1000.00", "รายละเอียด":"โอนเงินบุคคลอื่น นายตัวอย่าง ตัวอย่าง"},
      {"วันที่":"01/01/21", "เวลา": "12.12", "เลขที่รายการ": "1234567890", "ยอดเงินคงเหลือ":"1000.00", "รายละเอียด":"โอนเงินบุคคลอื่น นายตัวอย่าง ตัวอย่าง"},
      {"วันที่":"01/01/21", "เวลา": "12.12", "เลขที่รายการ": "1234567890", "ยอดเงินคงเหลือ":"1000.00", "รายละเอียด":"โอนเงินบุคคลอื่น นายตัวอย่าง ตัวอย่าง"},
      {"วันที่":"01/01/21", "เวลา": "12.12", "เลขที่รายการ": "1234567890", "ยอดเงินคงเหลือ":"1000.00", "รายละเอียด":"โอนเงินบุคคลอื่น นายตัวอย่าง ตัวอย่าง"},
      {"วันที่":"01/01/21", "เวลา": "12.12", "เลขที่รายการ": "1234567890", "ยอดเงินคงเหลือ":"1000.00", "รายละเอียด":"โอนเงินบุคคลอื่น นายตัวอย่าง ตัวอย่าง"}
    ];
  }
  // This function will contain widgets for the main body
  Widget makeBody(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              headingRowHeight: _height*0.05,
              columnSpacing: _height*0.03,
              dataRowHeight: _height*0.05,
              sortAscending: true,
              columns: tableColumns(context),
              rows: List.generate(
                _generatePDFData().length,
                (index) => _getDataRow(_generatePDFData()[index],context),
              ),
            ),
          ));
  }

  //_dataRow function will populate the table rows
     DataRow _getDataRow(dynamic data, BuildContext context) {
       final double _height = MediaQuery.of(context).size.height;
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          data['วันที่'].toString(),
          style: TextStyle(fontSize: _height*0.024),
        )),
        DataCell(Text(
          data['เวลา'].toString(),
          style: TextStyle(fontSize: _height*0.024),
        )),
        DataCell(Text(
          data['เลขที่รายการ'].toString(),
          style: TextStyle(fontSize: _height*0.024),
        )),
        DataCell(Text(
          data['ยอดเงินคงเหลือ'].toString(),
          style: TextStyle(fontSize: _height*0.024),
        )),
        DataCell(Text(
          data['รายละเอียด'].toString(),
          style: TextStyle(fontSize: _height*0.024),
        )),
      ],
    );
  }

  //function to populate table columns
   List<DataColumn> tableColumns(BuildContext context) {
     final double _height = MediaQuery.of(context).size.height;
      return [
        DataColumn(
          label: Padding(
            padding: EdgeInsets.only(top: _height*0.01, bottom: _height*0.01),
            child: Text(
              "วันที่",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: _height*0.023,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Padding(
            padding: EdgeInsets.only(top: _height*0.01, bottom: _height*0.01),
            child: Text(
              "เวลา",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: _height*0.023,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Padding(
            padding: EdgeInsets.only(top: _height*0.01, bottom: _height*0.01),
            child: Text(
              "เลขที่รายการ",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: _height*0.023,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Padding(
            padding: EdgeInsets.only(top: _height*0.01, bottom: _height*0.01),
            child: Text(
              "ยอดเงินคงเหลือ",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: _height*0.023,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Padding(
            padding: EdgeInsets.only(top: _height*0.01, bottom: _height*0.01),
            child: Text(
              "รายละเอียด",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: _height*0.023,
              ),
            ),
          ),
        )
      ];
    }