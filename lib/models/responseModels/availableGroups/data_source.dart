import 'dart:convert';

import 'creator.dart';

class AvailableGroupsDataSource {
  int? id;
  String? name;
  Creator? creator;
  String? image;

  AvailableGroupsDataSource({this.id, this.name, this.creator, this.image});

  factory AvailableGroupsDataSource.fromJson(Map<String, dynamic> json) => AvailableGroupsDataSource(
        id: json['id'] as int?,
        name: json['name'] as String?,
        creator: json['creator'] == null
            ? null
            : Creator.fromJson(json['creator'] as Map<String, dynamic>),
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'creator': creator?.toJson(),
        'image': image,
      };

      static Map<String, dynamic> toMap(
          AvailableGroupsDataSource availableGroupsDataSource) =>
      {
        'id': availableGroupsDataSource.id,
        'name': availableGroupsDataSource.name,
        'creator': availableGroupsDataSource.creator!.toJson(),
        'image': availableGroupsDataSource.image,
        
      };

  static String encode(
          List<AvailableGroupsDataSource> availableGroupsDataSourceList) =>
      json.encode(
        availableGroupsDataSourceList
            .map<Map<String, dynamic>>((availableGroupsDataSource) =>
                AvailableGroupsDataSource.toMap(availableGroupsDataSource))
            .toList(),
      );

  static List<AvailableGroupsDataSource> decode(
      String availableGroupsDataSource) {
    return availableGroupsDataSource != null
        ? (json.decode(availableGroupsDataSource) ?? [])
            .map<AvailableGroupsDataSource>(
                (item) => AvailableGroupsDataSource.fromJson(item))
            .toList()
        : [];
  }
}
