import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/company_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';

part 'company_donation_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyDonation {
  ForProfitCompany company;
  double amount;
  Atrocity? atrocity;
  NonProfit? nonprofit;
  @JsonKey(name: 'user_matched')
  Profile userMatched;
  @JsonKey(name: 'donation_date')
  String donationDate;

  CompanyDonation(
      this.company, this.donationDate, this.userMatched, this.amount,
      [this.atrocity, this.nonprofit]);

  factory CompanyDonation.fromJson(Map<String, dynamic> data) =>
      _$CompanyDonationFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyDonationToJson(this);
}
