import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kodiarytask/models/dynamicDataModel/dynamicDataModel.dart';

final dynamicFormServiceProvider =
    ChangeNotifierProvider((ref) => DynamicFormService._());

class DynamicFormService extends ChangeNotifier {
  DynamicFormService._();

  final Map<String, dynamic> preps = {};
  makeNecessaryPreps(List<Field> field) {
    for (var element in field) {
      switch (element.fieldType) {
        case "TextInput":
          preps[element.name] = TextEditingController();
        case "DatetimePicker":
          preps[element.name] = DateTime.now();
        case "Switch":
          preps[element.name] = false;
      }
    }
  }

  findInMapAndChangeValue(String key, dynamic value, String type) {
    if (type == "TextInput") {
      preps[key] = TextEditingController(text: value);
    } else {
      preps[key] = value;
      notifyListeners();
    }

    // print(value);
  }

  dynamic returnValue(String key) {
    return preps[key];
  }
}
