// To parse this JSON data, do
//
//      investorModel = investorModelFromJson(jsonString);

import 'dart:convert';

InvestorModel investorModelFromJson(String str) =>
    InvestorModel.fromJson(json.decode(str));

String investorModelToJson(InvestorModel data) => json.encode(data.toJson());

class InvestorModel {
  int id;
  dynamic imageLocation;
  dynamic fullName;
  dynamic phoneNumber;
  dynamic email;
  dynamic password;
  dynamic address;
  dynamic nidNumber;
  dynamic nidFrontImageLocation;
  dynamic nidBackImageLocation;
  dynamic bankName;
  dynamic bankBranchName;
  dynamic accountHolderName;
  dynamic accountNumber;
  dynamic nomineeName;
  dynamic relationship;
  dynamic nomineePhoneNumber;
  dynamic nomineeNidNumber;
  dynamic nomineeNidFrontImageLocation;
  dynamic nomineeNidBackImageLocation;
  dynamic token;
  dynamic ongoingFunded;
  dynamic investmentRefund;
  dynamic totalProfit;
  String referralId;
  dynamic referredById;
  dynamic referredPoints;
  dynamic totalRegistered;

  InvestorModel({
    required this.id,
    required this.imageLocation,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.address,
    required this.nidNumber,
    required this.nidFrontImageLocation,
    required this.nidBackImageLocation,
    required this.bankName,
    required this.bankBranchName,
    required this.accountHolderName,
    required this.accountNumber,
    required this.nomineeName,
    required this.relationship,
    required this.nomineePhoneNumber,
    required this.nomineeNidNumber,
    required this.nomineeNidFrontImageLocation,
    required this.nomineeNidBackImageLocation,
    required this.token,
    required this.ongoingFunded,
    required this.investmentRefund,
    required this.totalProfit,
    required this.referralId,
    required this.totalRegistered,
    required this.referredById,
    required this.referredPoints,
  });

  factory InvestorModel.fromJson(Map<String, dynamic> json) => InvestorModel(
        id: json["id"],
        imageLocation: json["image_location"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        nidNumber: json["nid_number"],
        nidFrontImageLocation: json["nid_front_image_location"],
        nidBackImageLocation: json["nid_back_image_location"],
        bankName: json["bank_name"],
        bankBranchName: json["bank_branch_name"],
        accountHolderName: json["account_holder_name"],
        accountNumber: json["account_number"],
        nomineeName: json["nominee_name"],
        relationship: json["relationship"],
        nomineePhoneNumber: json["nominee_phone_number"],
        nomineeNidNumber: json["nominee_nid_number"],
        nomineeNidFrontImageLocation: json["nominee_nid_front_image_location"],
        nomineeNidBackImageLocation: json["nominee_nid_back_image_location"],
        token: json["token"],
        ongoingFunded: json["ongoing_funded"],
        investmentRefund: json["investment_refund"],
        totalProfit: json["total_profit"],
        referralId: json["referral_id"],
        referredById: json["referred_by_id"],
        referredPoints: json["referred_points"],
        totalRegistered: json["total_registered"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_location": imageLocation,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "email": email,
        "password": password,
        "address": address,
        "nid_number": nidNumber,
        "nid_front_image_location": nidFrontImageLocation,
        "nid_back_image_location": nidBackImageLocation,
        "bank_name": bankName,
        "bank_branch_name": bankBranchName,
        "account_holder_name": accountHolderName,
        "account_number": accountNumber,
        "nominee_name": nomineeName,
        "relationship": relationship,
        "nominee_phone_number": nomineePhoneNumber,
        "nominee_nid_number": nomineeNidNumber,
        "nominee_nid_front_image_location": nomineeNidFrontImageLocation,
        "nominee_nid_back_image_location": nomineeNidBackImageLocation,
        "token": token,
        "ongoing_funded": ongoingFunded,
        "investment_refund": investmentRefund,
        "total_profit": totalProfit,
        "referral_id": referralId,
        "referred_by_id": referredById,
        "referred_points": referredPoints,
        "total_registered": totalRegistered,
      };
}
