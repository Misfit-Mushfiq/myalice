class NoteResponse {
  bool? success;
  NoteDataSource? dataSource;

  NoteResponse({this.success, this.dataSource});

  NoteResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    dataSource = json['dataSource'] != null
        ? new NoteDataSource.fromJson(json['dataSource'])
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

class NoteDataSource {
  var nId;
  int? timestamp;
  int ?customerId;
  int ?platformId;
  int ?projectId;
  String? platformType;
  String? conversationId;
  Data ?data;
  String ?source;
  String? type;
  int ?adminId;
  AdminInfo? adminInfo;
  bool ?success;
  String ?pusherKey;

  NoteDataSource(
      {this.nId,
      this.timestamp,
      this.customerId,
      this.platformId,
      this.projectId,
      this.platformType,
      this.conversationId,
      this.data,
      this.source,
      this.type,
      this.adminId,
      this.adminInfo,
      this.success,
      this.pusherKey});

  NoteDataSource.fromJson(Map<String, dynamic> json) {
    nId = json['_id'];
    timestamp = json['timestamp'];
    customerId = json['customer_id'];
    platformId = json['platform_id'];
    projectId = json['project_id'];
    platformType = json['platform_type'];
    conversationId = json['conversation_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    source = json['source'];
    type = json['type'];
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
    data['timestamp'] = this.timestamp;
    data['customer_id'] = this.customerId;
    data['platform_id'] = this.platformId;
    data['project_id'] = this.projectId;
    data['platform_type'] = this.platformType;
    data['conversation_id'] = this.conversationId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['source'] = this.source;
    data['type'] = this.type;
    data['admin_id'] = this.adminId;
    if (this.adminInfo != null) {
      data['admin_info'] = this.adminInfo!.toJson();
    }
    data['success'] = this.success;
    data['pusher_key'] = this.pusherKey;
    return data;
  }
}

class Data {
  String? type;
  NData? data;

  Data({this.type, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? new NData.fromJson(json['data']) : null;
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

class NData {
  String? subType;
  String ?text;

  NData({this.subType, this.text});

  NData.fromJson(Map<String, dynamic> json) {
    subType = json['sub_type'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_type'] = this.subType;
    data['text'] = this.text;
    return data;
  }
}

class AdminInfo {
  int? id;
  String? email;
  String ?avatar;
  String ?fullName;

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