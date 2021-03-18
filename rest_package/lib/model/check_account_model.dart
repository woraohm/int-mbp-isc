class CheckAccountModel{
   String accountNo;
   String accountName;
   String bankName;
   String accountType;
   double availableBalance;

   CheckAccountModel({
     this.bankName,
     this.accountName,
     this.accountNo,
     this.accountType,
     this.availableBalance
   });
}