class SendChat {
  bool? success;
  DataSource? dataSource;

  SendChat({this.success, this.dataSource});

  SendChat.fromJson(Map<String, dynamic> json) {
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
  Null? nId;
  String? type;
  String? source;
  String? platformType;
  int? platformId;
  int? customerId;
  int? projectId;
  Data? data;
  String? conversationId;
  int? timestamp;
  int? adminId;
  AdminInfo? adminInfo;
  Null? success;
  String? pusherKey;

  DataSource(
      {this.nId,
      this.type,
      this.source,
      this.platformType,
      this.platformId,
      this.customerId,
      this.projectId,
      this.data,
      this.conversationId,
      this.timestamp,
      this.adminId,
      this.adminInfo,
      this.success,
      this.pusherKey});

  DataSource.fromJson(Map<String, dynamic> json) {
    nId = json['_id'];
    type = json['type'];
    source = json['source'];
    platformType = json['platform_type'];
    platformId = json['platform_id'];
    customerId = json['customer_id'];
    projectId = json['project_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    conversationId = json['conversation_id'];
    timestamp = json['timestamp'];
    adminId = json['admin_id'];
    adminInfo = json['admin_info'] != null
        ? new AdminInfo.fromJson(json['admin_info'])
        : null;
    success = json['success'];
    pusherKey = json['pusher_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.nId;
    data['type'] = this.type;
    data['source'] = this.source;
    data['platform_type'] = this.platformType;
    data['platform_id'] = this.platformId;
    data['customer_id'] = this.customerId;
    data['project_id'] = this.projectId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['conversation_id'] = this.conversationId;
    data['timestamp'] = this.timestamp;
    data['admin_id'] = this.adminId;
    if (this.adminInfo != null) {
      data['admin_info'] = this.adminInfo!.toJson();
    }
    data['success'] = this.success;
    data['pusher_key'] = this.pusherKey;
    return data;
  }
}

class SendData {
  String? type;
  Data? data;

  SendData({this.type, this.data});

  SendData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? text;

  Data({this.text});

  Data.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class AdminInfo {
  int? id;
  String? email;
  String? avatar;
  String? fullName;

  AdminInfo({this.id, this.email, this.avatar, this.fullName});

  AdminInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    avatar = json['avatar'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['full_name'] = this.fullName;
    return data;
  }
}