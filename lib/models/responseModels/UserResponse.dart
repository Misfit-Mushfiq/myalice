class UserInfoResponse {
  bool? success;
  DataSource? dataSource;

  UserInfoResponse({this.success, this.dataSource});

  UserInfoResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    dataSource = json['dataSource'] != null
        ? new DataSource.fromJson(json['dataSource'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.dataSource != null) {
      data['dataSource'] = this.dataSource!.toJson();
    }
    return data;
  }
}

class DataSource {
  int? id;
  int? onboardCompletionState;
  String? email;
  String? avatar;
  String? firstName;
  String? lastName;
  String? fullName;
  String? companyType;
  String? monthlySupportReach;
  String? companySupportSize;
  int? credit;
  List<Null>? cardInfo;
  String? phone;
  bool? isVerified;
  int? trialRemaining;
  bool? trialAvailed;
  String? status;
  String? lastOnlineTime;
  String? lastOfflineTime;

  DataSource(
      {this.id,
      this.onboardCompletionState,
      this.email,
      this.avatar,
      this.firstName,
      this.lastName,
      this.fullName,
      this.companyType,
      this.monthlySupportReach,
      this.companySupportSize,
      this.credit,
      this.cardInfo,
      this.phone,
      this.isVerified,
      this.trialRemaining,
      this.trialAvailed,
      this.status,
      this.lastOnlineTime,
      this.lastOfflineTime});

  DataSource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    onboardCompletionState = json['onboard_completion_state'];
    email = json['email'];
    avatar = json['avatar'] ?? "";
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    companyType = json['company_type'];
    monthlySupportReach = json['monthly_support_reach'];
    companySupportSize = json['company_support_size'];
    credit = json['credit'];
    /* if (json['card_info'] != null) {
      cardInfo = new List<Null>();
      json['card_info'].forEach((v) {
        cardInfo.add(new Null.fromJson(v));
      });
    } */
    phone = json['phone'];
    isVerified = json['is_verified'];
    trialRemaining = json['trial_remaining'];
    trialAvailed = json['trial_availed'];
    status = json['status'];
    lastOnlineTime = json['last_online_time'];
    lastOfflineTime = json['last_offline_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['onboard_completion_state'] = this.onboardCompletionState;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['full_name'] = this.fullName;
    data['company_type'] = this.companyType;
    data['monthly_support_reach'] = this.monthlySupportReach;
    data['company_support_size'] = this.companySupportSize;
    data['credit'] = this.credit;
    /* if (this.cardInfo != null) {
      data['card_info'] = this.cardInfo.map((v) => v.toJson()).toList();
    } */
    data['phone'] = this.phone;
    data['is_verified'] = this.isVerified;
    data['trial_remaining'] = this.trialRemaining;
    data['trial_availed'] = this.trialAvailed;
    data['status'] = this.status;
    data['last_online_time'] = this.lastOnlineTime;
    data['last_offline_time'] = this.lastOfflineTime;
    return data;
  }
}
