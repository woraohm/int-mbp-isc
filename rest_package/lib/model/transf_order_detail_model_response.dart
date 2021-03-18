class TransfOrderDetailModelResponse{
  String traceNo;
  String dateTime;
  String sender_Account_No;
  String bank_Name_Sender;
  String lk_acct_type_name;
  String bank_Name_Recipient;
  String recipient_account_No;
  String recipient_account_No_name_Th;
  String recipient_account_No_name_En;
  String note;
  double fee;
  double amount;
  String trnStatus;

  TransfOrderDetailModelResponse({
    this.amount,
    this.bank_Name_Recipient,
    this.bank_Name_Sender,
    this.dateTime,
    this.fee,
    this.note,
    this.recipient_account_No,
    this.recipient_account_No_name_En,
    this.recipient_account_No_name_Th,
    this.sender_Account_No,
    this.traceNo,
    this.trnStatus,
    this.lk_acct_type_name
  });
}