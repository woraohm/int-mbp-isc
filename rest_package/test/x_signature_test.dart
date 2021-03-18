
import 'package:flutter_test/flutter_test.dart';
import 'package:rest_package/generator/x_signature.dart';

void main(){
  test("Gen X-Signature Correct", (){
    print("Gen:X-Signature= ${XSignature().generate()}");
  });
}