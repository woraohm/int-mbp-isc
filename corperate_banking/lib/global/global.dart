library my_prj.globals;


import 'package:rest_package/model/select_account_to_add_group_list_model.dart';


bool isLoggedIn = false;
String status="";
String staffFname="";
String staffLname="";
String staffEmail="";
String staffThem="";
String nameTHCompany="";
String staffMobile="";
String staffProfile="";
String token="";

List<SelectAccountToAddGroupModel>tempListToAddGroup=[];
DateTime now = DateTime.now();
//statemment
String selectAccount="";
String selectDateTime="";



//String restMyIPV4ISC ="192.168.253.103";
//String restdreamIPV4 = "192.168.253.59";
//String ohm ="172.20.10.12"
String iPV4 = "192.168.253.59";

