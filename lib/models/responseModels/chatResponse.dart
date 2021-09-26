class ChatResponse {
  bool? success;
  List<DataSource>? dataSource;
  List<Actions>? actions;
  Data? data;

  ChatResponse({this.success, this.dataSource, this.actions});

  ChatResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    if (json['dataSource'] != null) {
      dataSource = <DataSource>[];
      json['dataSource'].forEach((v) {
        dataSource!.add(new DataSource.fromJson(v));
      });
    }
    if (json['actions'] != null) {
      actions = <Actions>[];
      json['actions'].forEach((v) {
        actions!.add(new Actions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.dataSource != null) {
      data['dataSource'] = this.dataSource!.map((v) => v.toJson()).toList();
    }
    if (this.actions != null) {
      data['actions'] = this.actions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataSource {
  String? sId;
  String? source;
  String? type;
  String? platformType;
  //int? conversationId;
  int? timestamp;
  int? platformId;
  int? projectId;
  int? customerId;
  Data? data;
  bool? success;
  Report? report;
  int? adminId;
  AdminInfo? adminInfo;

  //For DB
  String? text;
  String? imageUrl;
  String? subType;

  DataSource(
      {this.sId,
      this.source,
      this.type,
      this.platformType,
      // this.conversationId,
      this.timestamp,
      this.platformId,
      this.projectId,
      this.customerId,
      this.data,
      this.success,
      this.report,
      this.adminId,
      this.adminInfo,
      this.text,
      this.imageUrl,
      this.subType});

  DataSource.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    source = json['source'];
    type = json['type'];
    platformType = json['platform_type'];
    //conversationId = json['conversation_id'];
    timestamp = json['timestamp'];
    platformId = json['platform_id'];
    projectId = json['project_id'];
    customerId = json['customer_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
    report =
        json['report'] != null ? new Report.fromJson(json['report']) : null;
    adminId = json['admin_id'];
    adminInfo = json['admin_info'] != null
        ? new AdminInfo.fromJson(json['admin_info'])
        : null;
    this.text = json['text'];
    this.imageUrl = json['image_url'];
    this.subType = json['sub_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['source'] = this.source;
    data['type'] = this.type;
    data['platform_type'] = this.platformType;
    //data['conversation_id'] = this.conversationId;
    data['timestamp'] = this.timestamp;
    data['platform_id'] = this.platformId;
    data['project_id'] = this.projectId;
    data['customer_id'] = this.customerId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    if (this.report != null) {
      data['report'] = this.report!.toJson();
    }
    data['admin_id'] = this.adminId;
    if (this.adminInfo != null) {
      data['admin_info'] = this.adminInfo!.toJson();
    }
    return data;
  }

  Map<String, dynamic> toJsonForDB() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] =
        this.source == "customer" ? this.data!.text : this.data!.data!.text;
    data['image_url'] = this.source == "customer"
        ? this.data!.type == "attachment"
            ? this.data!.attachment!.type == "image"
                ? this.data!.attachment!.urls!.elementAt(0)
                : ""
            : ""
        : this.data!.type == "attachment"
            ? this.data!.data!.subType == "image"
                ? this.data!.data!.urls!.elementAt(0)
                : ""
            : "";
    data['source'] = this.source;
    data['type'] = this.data!.type;
    data['sub_type'] = this.source == "admin"
        ? this.data!.type == "attachment"
            ? this.data!.data!.subType
            : ""
        : this.data!.type == "attachment"
            ? this.data!.attachment!.type
            : "";
    return data;
  }

  @override
  String toString() {
    return 'Chats {text : ${this.source == "customer" ? this.data!.text : this.data!.data!.text}}';
  }
}

class Data {
  String? type;
  String? text;
  String? payload;
  //Null extra;
  Datam? data;
  Attachment? attachment;

  Data(
      {this.type,
      this.text,
      this.payload,
      /* this.extra, */ this.data,
      this.attachment});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    text = json['text'];
    payload = json['payload'];
    //extra = json['extra'];
    data = json['data'] != null ? new Datam.fromJson(json['data']) : null;

    attachment = json["attachment"] != null
        ? Attachment.fromJson(json["attachment"])
        : Attachment();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['text'] = this.text;
    data['payload'] = this.payload;
    //data['extra'] = this.extra;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    attachment = data['attachment'] != null
        ? new Attachment.fromJson(data['attachment'])
        : null;
    return data;
  }
}

class Attachment {
  String? type;
  List<String>? urls;

  Attachment({this.type, this.urls});

  Attachment.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    urls = json['urls'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['urls'] = this.urls;
    return data;
  }
}

class Datam {
  String? text;
  bool? save;
  //Null attribute;
  List<Buttons>? buttons;
   List<Elements>? elements;
  //Null api;
  String? subType;
  List<String>? urls;

  Datam(
      {this.text,
      this.save,
      //this.attribute,
      this.buttons,
      //this.api,
      this.subType,this.elements});

  Datam.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    save = json['save'];
    if (json['urls'] != null) {
      urls = json['urls'].cast<String>();
    }

     if (json['elements'] != null) {
      elements =  <Elements>[];
      json['elements'].forEach((v) {
        elements!.add(new Elements.fromJson(v));
      });
    }

    //attribute = json['attribute'];
    if (json['buttons'] != null) {
      buttons = <Buttons>[];
      json['buttons'].forEach((v) {
        buttons!.add(new Buttons.fromJson(v));
      });
    }
    // api = json['api'];
    subType = json['sub_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['save'] = this.save;
    // data['attribute'] = this.attribute;
     if (this.elements != null) {
      data['elements'] = this.elements!.map((v) => v.toJson()).toList();
    }
    if (this.buttons != null) {
      data['buttons'] = this.buttons!.map((v) => v.toJson()).toList();
    }
    //data['api'] = this.api;
    data['sub_type'] = this.subType;
    data['urls'] = this.urls;
    return data;
  }
}

class Elements {
  int? id;
  String? url;
  String? image;
  String? title;
  List<ElementButtons>? buttons;
  String? subtitle;

  Elements(
      {this.id, this.url, this.image, this.title, this.buttons, this.subtitle});

  Elements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    image = json['image'];
    title = json['title'];
    if (json['buttons'] != null) {
      buttons =  <ElementButtons>[];
      json['buttons'].forEach((v) {
        buttons!.add(new ElementButtons.fromJson(v));
      });
    }
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['image'] = this.image;
    data['title'] = this.title;
    if (this.buttons != null) {
      data['buttons'] = this.buttons!.map((v) => v.toJson()).toList();
    }
    data['subtitle'] = this.subtitle;
    return data;
  }
}

class ElementButtons {
  int? id;
  String? type;
  String? extra;
  String? title;
  String? value;
  String? payload;
  String? verbose;
  int? formSequence;
  //Null formSequenceTitle;
  bool? messengerExtensions;
  String? webviewHeightRatio;

  ElementButtons(
      {this.id,
      this.type,
      this.extra,
      this.title,
      this.value,
      this.payload,
      this.verbose,
      this.formSequence,
     // this.formSequenceTitle,
      this.messengerExtensions,
      this.webviewHeightRatio});

  ElementButtons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    extra = json['extra'];
    title = json['title'];
    value = json['value'].toString();
    payload = json['payload'];
    verbose = json['verbose'];
    formSequence = json['form_sequence'];
   // formSequenceTitle = json['form_sequence_title'];
    messengerExtensions = json['messenger_extensions'];
    webviewHeightRatio = json['webview_height_ratio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['extra'] = this.extra;
    data['title'] = this.title;
    data['value'] = this.value;
    data['payload'] = this.payload;
    data['verbose'] = this.verbose;
    data['form_sequence'] = this.formSequence;
   // data['form_sequence_title'] = this.formSequenceTitle;
    data['messenger_extensions'] = this.messengerExtensions;
    data['webview_height_ratio'] = this.webviewHeightRatio;
    return data;
  }
}

class Buttons {
  int? columns;
  int? rows;
  String? text;
  String? actionType;
  String? actionBody;

  Buttons(
      {this.columns, this.rows, this.text, this.actionType, this.actionBody});

  Buttons.fromJson(Map<String, dynamic> json) {
    columns = json['Columns'];
    rows = json['Rows'];
    text = json['Text'];
    actionType = json['ActionType'];
    actionBody = json['ActionBody'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Columns'] = this.columns;
    data['Rows'] = this.rows;
    data['Text'] = this.text;
    data['ActionType'] = this.actionType;
    data['ActionBody'] = this.actionBody;
    return data;
  }
}

class Report {
  int? status;
  String? statusMessage;
  int? messageToken;
  String? chatHostname;

  Report(
      {this.status, this.statusMessage, this.messageToken, this.chatHostname});

  Report.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    messageToken = json['message_token'];
    chatHostname = json['chat_hostname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_message'] = this.statusMessage;
    data['message_token'] = this.messageToken;
    data['chat_hostname'] = this.chatHostname;
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

class Actions {
  String? action;
  bool? isAllowed;

  Actions({this.action, this.isAllowed});

  Actions.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    isAllowed = json['is_allowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action'] = this.action;
    data['is_allowed'] = this.isAllowed;
    return data;
  }
}
