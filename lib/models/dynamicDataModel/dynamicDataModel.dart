// To parse this JSON data, do
//
//     final dynamicDataModel = dynamicDataModelFromJson(jsonString);

import 'dart:convert';

DynamicDataModel dynamicDataModelFromJson(String str) =>
    DynamicDataModel.fromJson(json.decode(str));

String dynamicDataModelToJson(DynamicDataModel data) =>
    json.encode(data.toJson());

class DynamicDataModel {
  final String title;
  final List<Field> fields;
  final bool canDelete;

  DynamicDataModel({
    required this.title,
    required this.fields,
    required this.canDelete,
  });

  DynamicDataModel copyWith({
    String? title,
    List<Field>? fields,
    bool? canDelete,
  }) =>
      DynamicDataModel(
        title: title ?? this.title,
        fields: fields ?? this.fields,
        canDelete: canDelete ?? this.canDelete,
      );

  factory DynamicDataModel.fromJson(Map<String, dynamic> json) =>
      DynamicDataModel(
        title: json["title"],
        fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
        canDelete: json["canDelete"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
        "canDelete": canDelete,
      };
}

class Field {
  final String fieldType;
  final String name;

  Field({
    required this.fieldType,
    required this.name,
  });

  Field copyWith({
    String? fieldType,
    String? name,
  }) =>
      Field(
        fieldType: fieldType ?? this.fieldType,
        name: name ?? this.name,
      );

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        fieldType: json["fieldType"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "fieldType": fieldType,
        "name": name,
      };
}
