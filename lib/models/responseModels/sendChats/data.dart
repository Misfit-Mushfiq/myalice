import 'package:myalice/models/responseModels/sendChats/attached_data.dart';

class Data {
  String? type;
  AttachedData? data;

  Data({this.type, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? new AttachedData.fromJson(json['data']) : null;
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