import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:corperate_banking/global/global.dart' as globals;


const PdfColor green = PdfColor.fromInt(0xffe06c6c); //darker background color
const PdfColor lightGreen =
    PdfColor.fromInt(0xffedabab); //light background color

const _darkColor = PdfColor.fromInt(0xff242424);
const _lightColor = PdfColor.fromInt(0xff9D9D9D);
const PdfColor baseColor = PdfColor.fromInt(0xffffffff);
const PdfColor _baseTextColor = PdfColor.fromInt(0xff000000);
const PdfColor accentColor = PdfColor.fromInt(0xff47539B);


//create pdf file
Future<bool> generatePDF(
    List<String> columns, List<List<String>> tableData) async {
  final PageTheme pageTheme = await _myPageTheme(PdfPageFormat.a4);

  Widget headerWidget = pdfHeader();

  final Document pdf = Document();
 
  pdf.addPage(MultiPage(
      pageTheme: pageTheme,
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        
        if (context.pageNumber == 1) {
          return null;
        }
        return Container();
      },
      footer: (Context context) {
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(globals.now.day.toString()+"/"+globals.now.month.toString()+"/"+globals.now.year.toString()),
                Text('Page ${context.pageNumber} of ${context.pagesCount}',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)
                )

            ] )
        );
            
            
            
      },
      build: (Context context) => <Widget>[
           
            Header(
              level: 0,
              child: headerWidget,
            ),
            Table.fromTextArray(
              context: context,
              headerAlignment: Alignment.center,
              cellAlignment: Alignment.centerLeft,
              headerDecoration: BoxDecoration(
                color: baseColor,
              ),
              headerHeight: 25,
              cellHeight: 30,
              headerStyle: TextStyle(
                
                color: _baseTextColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              cellStyle: const TextStyle(
                color: _darkColor,
                fontSize: 10,
              ),
              headers: List<String>.generate(
                columns.length,
                (col) {
                  return columns[col];
                },
              ),
              data: List<List<String>>.generate(
                tableData.length,
                (row) => List<String>.generate(
                  columns.length,
                  (col) {
                    return tableData[row][col];
                  },
                ),
              ),
            ),
          ]));

  try {
    Directory dir = await getExternalStorageDirectory();
    String filePath = dir.path + "/devbybit/";
    if (Directory(filePath).exists() != true) {
      Directory(filePath).createSync(recursive: true);
      final File file = File(filePath + "statement.pdf");
      file.writeAsBytesSync(pdf.save());
      

       

      return true;
    } else {
      final File file = File(filePath + "statement.pdf");
      file.writeAsBytesSync(pdf.save());
      return true;
    }
  } catch (e) {
    return false;
  }
}



showSuccessToast() {
  Fluttertoast.showToast(
      msg: "Your file has been exported successfully.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: material.Colors.blueAccent,
      textColor: material.Colors.white,
      fontSize: 16.0);
}

showErrorToast() {
  Fluttertoast.showToast(
      msg: "Exporting your file failed. Nothing was downloaded.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: material.Colors.redAccent,
      textColor: material.Colors.white,
      fontSize: 16.0);
}

//pdf document theme
Future<PageTheme> _myPageTheme(PdfPageFormat format) async {
 
  return PageTheme(
      pageFormat: format.applyMargin(
          left: 1.0 * PdfPageFormat.cm,
          top: 0.1 * PdfPageFormat.cm,
          right: 1.0 * PdfPageFormat.cm,
          bottom: 2.0 * PdfPageFormat.cm),
      theme: ThemeData.withFont(
        base: Font.ttf(await rootBundle.load("assests/fonts/ThaiSansNeue-Regular.ttf")),
      )

      // ThemeData.withFont(
//      base: pw.Font.ttf(await rootBundle.load('assets/fonts/nexa_bold.otf')),
//      bold:
//          pw.Font.ttf(await rootBundle.load('assets/fonts/raleway_medium.ttf')),
      // ),

      );
}

//pdf header body
Widget pdfHeader() {
  return Container(
    padding: const EdgeInsets.only(left: 0.1 * PdfPageFormat.cm, right: 0.1 * PdfPageFormat.cm, top: 0.1 * PdfPageFormat.cm, bottom: 1 * PdfPageFormat.cm),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text('บริษัทอินโนเวทีฟ ซอฟต์แวร์ คอลซัลติ้ง จำกัด',style: TextStyle(fontSize: 16, color: accentColor)),
              Text('innovative software consulting co. ltd',style: TextStyle(fontSize: 16))
            ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text('ใบแจ้งรายการบัญชี',style: TextStyle(fontSize: 16, color: accentColor)),
              Text('STATEMENT OF ACCOUNT',style: TextStyle(fontSize: 16))
            ])
            
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text('ชื่อ-สกุล',style: TextStyle(fontSize: 16,)),
              SizedBox(width: 4),
              Text(globals.staffFname+' '+globals.staffLname,style: TextStyle(fontSize: 16))
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text('เลขที่บัญชี',style: TextStyle(fontSize: 16,)),
              SizedBox(width: 4),
              Text(globals.selectAccount,style: TextStyle(fontSize: 16))
            ])
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text('ที่อยู่',style: TextStyle(fontSize: 16,)),
              SizedBox(width: 4),
              Text('707, อาคารญาดา ชั้น 7 ห้องเลขที่ 706 กรุงเทพ',style: TextStyle(fontSize: 16))
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text('วันที่',style: TextStyle(fontSize: 16,)),
              SizedBox(width: 4),
              Text(globals.selectDateTime,style: TextStyle(fontSize: 16))
            ])
          ]
        ),

        
        
      ]
    )
    
  );
  // return Container(
  //     decoration: const BoxDecoration(
  //       color: PdfColor.fromInt(0xffffffff),
  //     ),
  //     margin: const EdgeInsets.only(bottom: 8, top: 8),
  //     padding: const EdgeInsets.fromLTRB(10, 7, 10, 4),
  //     child: Column(children: [
  //       Text(
  //         "DevByBit",
  //         style: TextStyle(
  //             fontSize: 16, color: _darkColor, fontWeight: FontWeight.bold),
  //       ),
  //       Text("+254 700 123456",
  //           style: TextStyle(fontSize: 14, color: _darkColor)),
  //       Text("Nairobi, Kenya",
  //           style: TextStyle(fontSize: 14, color: _darkColor)),
  //     ]));
}
