import 'package:corperate_banking/screens/accounts_screen.dart';
import 'package:corperate_banking/screens/home_screen.dart';
import 'package:corperate_banking/screens/index_screen.dart';
import 'package:corperate_banking/screens/screen_auth/authorizer_screen/authorizer_approve_order_screen/authorizer_approve_not_success_screen.dart';
import 'package:corperate_banking/screens/screen_auth/authorizer_screen/authorizer_approve_order_screen/authorizer_approve_order_screen.dart';
import 'package:corperate_banking/screens/screen_auth/authorizer_screen/authorizer_approve_order_screen/authorizer_approve_success_screen.dart';
import 'package:corperate_banking/screens/screen_auth/authorizer_screen/authorizer_approve_order_screen/authorizer_check_screen.dart';
import 'package:corperate_banking/screens/screen_auth/authorizer_screen/authorizer_history_screen/authorizer_hisrory_order_screen.dart';
import 'package:corperate_banking/screens/screen_auth/authorizer_screen/authorizer_history_screen/authorizer_history_screen.dart';
import 'package:corperate_banking/screens/screen_auth/authorizer_screen/authorizer_home_screen.dart';
import 'package:corperate_banking/screens/screen_auth/authorizer_screen/authorizer_setting_screen/authorizer_setting_screen.dart';
import 'package:corperate_banking/screens/screen_auth/checker_screen/checkerHome_screen.dart';
import 'package:corperate_banking/screens/screen_auth/checker_screen/checker_check_screen/checker_check_success_screen.dart';
import 'package:corperate_banking/screens/screen_auth/checker_screen/checker_check_screen/checker_checking_screen.dart';
import 'package:corperate_banking/screens/screen_auth/checker_screen/checker_check_screen/checker_reason_not_pass.dart';
import 'package:corperate_banking/screens/screen_auth/checker_screen/checker_history_screen/checker_history_order_screen.dart';
import 'package:corperate_banking/screens/screen_auth/checker_screen/checker_history_screen/checker_history_screen.dart';
import 'package:corperate_banking/screens/screen_auth/checker_screen/checker_order_screen/checker_order_screen.dart';
import 'package:corperate_banking/screens/screen_auth/checker_screen/checker_setting_screen/checker_setting_screen.dart';

import 'package:corperate_banking/screens/screen_auth/login_screen.dart';
import 'package:corperate_banking/screens/screen_auth/splash_screen.dart';
import 'package:corperate_banking/screens/screens_order/dischecker_screen.dart';
import 'package:corperate_banking/screens/screens_order/transferSingle_agian_screen.dart';
import 'package:corperate_banking/screens/screens_order/order-detail_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screen_addAccount/add_account_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screen_addAccount/check_acct_other_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screen_addAccount/check_add_promptpay.dart';
import 'package:corperate_banking/screens/screens_transaction/screen_addFavourate/add_favourite_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/select_account_to_add_group_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/create_group_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/create_order_multi_transfer_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/first_screen_select_group.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/manage_group_recipient_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/manage_recipient_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/second_screen_view_group.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_multi_transfer/third_screen_check_multi.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_scan/scan_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_transfer/check_transfer_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_transfer/numpad_transfer_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_transfer/create_order_transfer_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_transfer/screen_transfer_favourite/transfer_fav_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_transfer/transfer_single1_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/screens_transfer/transfer_single_screen.dart';
import 'package:corperate_banking/screens/screens_transaction/transaction_screen.dart';
import 'package:corperate_banking/screens/setting_screen.dart';
import 'package:corperate_banking/screens/statement/statement_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:responsive_framework/responsive_framework.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.resize(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          
          ),
          initialRoute: "/",
      title: 'Corperate_banking',
      theme: ThemeData(
        fontFamily: "ThaiSansNeue",
        primaryColor: Color(0xFF3b074b)
        
    
      ),


      home:SplashPage(),
      routes: {
        //Maker
        //Maker - Main
        '/Accounts_screen': (context) => AccountsScreen(),
        '/HomeScreen': (context) => HomeScreen(),
        '/IndexScreen': (context) => IndexScreen(),
         '/Login_screen': (context) => LoginScreen(),

        //Maker-transaction
        '/TransactionScreen': (context) => TransactionScreen(),
        '/Transfer-single_screen': (context) => TransferSingle(),
        '/Add-favourite_screen': (context) => AddFavouriteScreen(),
        '/Add-account_screen': (context) => AddAccountScreen(),
        '/Check-add-acct-other_screen': (context) => CheckAddAcctOtherScreen(),
        '/Check-add-promptpay_screen': (context) => CheckAddPromptpayScreen(),

        //Maker - transfer-single-main
        '/Numpad-transfer_screen': (context) => NumpadScreen(),
        '/Transfer-single1_screen': (context) => TransferSingle1(),
        '/Check-transfer_screen': (context) => CheckTransferScreen(),
        '/Create-order-transfer_screen': (context) => CreateOrderTransferScreen(),

        //Maker - Order
        '/Order-detail_screen': (context) => OrderDetailScreen(),
        '/Dis-checker_screen': (context) => DischeckerScreen(),

        //Maker- statement
        '/Statement_screen': (context) => StatementScreen(),

        //Setting
        '/Setting_screen': (context) => SettingScreen(),

        //ScanTransf
        '/Scan-data-transf_Screen': (context) => ScanDataTransfScreen(),

        //Maker-Multi-Transfer
        '/Select-group_screen': (context) => SelectGroup(),
        '/Create-group_screen': (context) => CreateGroupMultiTransferScreen(),
        '/Manage-group-recipient_screen': (context) => ManageGroupRecipientScreen(),  
        '/Add-account-to-group_screen': (context) => AddAccountToGroupScreen(),
        '/Manage-recipient_screen': (context) => ManageRecipientScreen(),
        '/View-group_screen': (context) => ViewGroupScreen(),
        '/check-multi-transfer_screen': (context) => CheckMultiTransferScreen(),
        '/Create-order-multi-transfer_screen': (context) => CreateOrderMultiTrasnferScreen(),
        
        
       
        
        
        
        
        
        '/TransferSingle-Agian_screen': (context) => TransferSingleAgainScreen(),
        '/Transfer-single-favourite_screen': (context) => TransferSingleFavScreen(),
        
        //checker
        '/Checker-home_screen': (context)=> CheckerHomeScreen(),
        '/Checker-order_screen': (context) => CheckerOrderScreen(),
        '/Checker-history_order_screen': (context) => HistoryCheckerOrderScreen(),
        '/Checker-checking_screen': (context) => CheckerCheckingScreen(),
        '/Checker-check-not-pass-reason_screen': (context) => CheckerCheckNotPassReasonScreen(),
        '/Checker-check_success_screen': (context) => CheckerCheckOrederSuccessScreen(),
        '/Checker-history_screen': (context) => HistoryCheckerScreen(),
        '/Checker-setting_screen': (context) => CheckerSettingScreen(),


        //authorizer
        '/Authorizer-home_screen': (context) => AuthorizerHomeScreen(),
        '/Authorizer-approve-order_screen': (context) => AuthorizerApproveOrderScreen(),
        '/Authorizer-check_screen':(context) => AuthorizerCheckScreen(),
        '/Authorizer-history_screen': (context) => AuthorizerHistoryScreen(),
        '/Authorizer-history-order_screen': (context) => AuthorizerHistoryOrderScreen(),
        '/Authorizer-approve-success_screen': (context) => AuthorizerApproveSuccessScreen(),
        '/Authorizer-approve-not-success_screen': (context) => AuthorizerApproveNotSuccessScreen(),
        '/Authorizer-setting_screen': (context) => AuthorizerSettingScreen()
      },
    );
  }
}


