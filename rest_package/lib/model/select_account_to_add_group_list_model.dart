import 'package:json_annotation/json_annotation.dart';
part 'select_account_to_add_group_list_model.g.dart';

@JsonSerializable()
class SelectAccountToAddGroupModel {
  String bank_Name_Recipient;
  String recipient_account_No;
  String recipient_account_No_name_Th;
  String recipient_account_No_name_En;
  double transAmount;

  SelectAccountToAddGroupModel(
      {this.bank_Name_Recipient,
      this.recipient_account_No,
      this.recipient_account_No_name_En,
      this.recipient_account_No_name_Th,
      this.transAmount});


      factory SelectAccountToAddGroupModel.fromJson(Map<String, dynamic> json) =>
      _$SelectAccountToAddGroupModelFromJson(json);

      Map<String, dynamic> toJson() => _$SelectAccountToAddGroupModelToJson(this);
}

