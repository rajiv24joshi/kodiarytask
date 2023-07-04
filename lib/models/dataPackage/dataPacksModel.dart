// To parse this JSON data, do
//
//     final dataPacks = dataPacksFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DataPacks dataPacksFromJson(String str) => DataPacks.fromJson(json.decode(str));

String dataPacksToJson(DataPacks data) => json.encode(data.toJson());

class DataPacks {
  final Data data;

  DataPacks({
    required this.data,
  });

  DataPacks copyWith({
    Data? data,
  }) =>
      DataPacks(
        data: data ?? this.data,
      );

  factory DataPacks.fromJson(Map<String, dynamic> json) => DataPacks(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final Gsm gsm;

  Data({
    required this.gsm,
  });

  Data copyWith({
    Gsm? gsm,
  }) =>
      Data(
        gsm: gsm ?? this.gsm,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        gsm: Gsm.fromJson(json["gsm"]),
      );

  Map<String, dynamic> toJson() => {
        "gsm": gsm.toJson(),
      };
}

class Gsm {
  final List<Prepaid> prepaid;

  Gsm({
    required this.prepaid,
  });

  Gsm copyWith({
    List<Prepaid>? prepaid,
  }) =>
      Gsm(
        prepaid: prepaid ?? this.prepaid,
      );

  factory Gsm.fromJson(Map<String, dynamic> json) => Gsm(
        prepaid:
            List<Prepaid>.from(json["prepaid"].map((x) => Prepaid.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "prepaid": List<dynamic>.from(prepaid.map((x) => x.toJson())),
      };
}

class Prepaid {
  final String title;
  final List<Subpackage> subpackages;

  Prepaid({
    required this.title,
    required this.subpackages,
  });

  Prepaid copyWith({
    String? title,
    List<Subpackage>? subpackages,
  }) =>
      Prepaid(
        title: title ?? this.title,
        subpackages: subpackages ?? this.subpackages,
      );

  factory Prepaid.fromJson(Map<String, dynamic> json) => Prepaid(
        title: json["title"],
        subpackages: List<Subpackage>.from(
            json["subpackages"].map((x) => Subpackage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subpackages": List<dynamic>.from(subpackages.map((x) => x.toJson())),
      };
}

class Subpackage {
  final String title;
  final List<Datapackage> datapackages;

  Subpackage({
    required this.title,
    required this.datapackages,
  });

  Subpackage copyWith({
    String? title,
    List<Datapackage>? datapackages,
  }) =>
      Subpackage(
        title: title ?? this.title,
        datapackages: datapackages ?? this.datapackages,
      );

  factory Subpackage.fromJson(Map<String, dynamic> json) => Subpackage(
        title: json["title"],
        datapackages: List<Datapackage>.from(
            json["datapackages"].map((x) => Datapackage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "datapackages": List<dynamic>.from(datapackages.map((x) => x.toJson())),
      };
}

class Datapackage {
  final int pId;
  final String title;
  final String packageTypeTitle;

  Datapackage({
    required this.pId,
    required this.title,
    required this.packageTypeTitle,
  });

  Datapackage copyWith({
    int? pId,
    String? title,
    String? packageTypeTitle,
  }) =>
      Datapackage(
        pId: pId ?? this.pId,
        title: title ?? this.title,
        packageTypeTitle: packageTypeTitle ?? this.packageTypeTitle,
      );

  factory Datapackage.fromJson(Map<String, dynamic> json) => Datapackage(
        pId: json["p_id"],
        title: json["title"],
        packageTypeTitle: json["package_type_title"],
      );

  Map<String, dynamic> toJson() => {
        "p_id": pId,
        "title": title,
        "package_type_title": packageTypeTitle,
      };
}
