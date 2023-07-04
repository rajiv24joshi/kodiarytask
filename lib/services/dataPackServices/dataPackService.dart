import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kodiarytask/models/dataPackage/dataPacksModel.dart';
import 'package:http/http.dart' as http;
import 'package:kodiarytask/models/dropDownValueModel/dropDownValueModel.dart';

final dataPackServiceProvider =
    ChangeNotifierProvider((ref) => DataPackService._());

class DataPackService extends ChangeNotifier {
  DataPackService._();

  late Gsm gsmDataPacks;
  final List<DropdownMenuItem<CustomMenuDropDown>> firstDropDown = [];
  final List<DropdownMenuItem<CustomMenuDropDown>> secondDropDown = [];
  final List<DropdownMenuItem<CustomMenuDropDown>> thirdDropDown = [];
  late DropdownMenuItem<CustomMenuDropDown> selectedFirstValue;
  late DropdownMenuItem<CustomMenuDropDown> selectedSecondValue;
  late DropdownMenuItem<CustomMenuDropDown> selectedThirdValue;
  final String url = "https://cms.ntc.net.np/api/datapackage-mobile";
  Future<bool> getDataPacks() async {
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var temp = dataPacksFromJson(response.body);
        gsmDataPacks = temp.data.gsm;
        addDataToFirstPack();
        addDataToSecondDrop();
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  addDataToFirstPack() {
    firstDropDown.clear();
    for (var element in gsmDataPacks.prepaid) {
      int index = gsmDataPacks.prepaid.indexOf(element);
      firstDropDown.add(DropdownMenuItem(
          value: CustomMenuDropDown(value: index, title: element.title),
          child: Text(element.title)));
    }
    selectFirstDropDownValue(0);
    notifyListeners();
  }

  selectFirstDropDownValue(int index) {
    selectedFirstValue = firstDropDown[index];
    addDataToSecondDrop();
    notifyListeners();
  }

  addDataToSecondDrop() {
    secondDropDown.clear();
    for (var element
        in gsmDataPacks.prepaid[selectedFirstValue.value!.value].subpackages) {
      int index = gsmDataPacks
          .prepaid[selectedFirstValue.value!.value].subpackages
          .indexOf(element);
      secondDropDown.add(DropdownMenuItem(
          value: CustomMenuDropDown(value: index, title: element.title),
          child: Text(element.title)));
    }
    selectSecondDropDownValue(0);

    notifyListeners();
  }

  selectSecondDropDownValue(int index) {
    selectedSecondValue = secondDropDown[index];
    addDataToThirdDrop();

    notifyListeners();
  }

  addDataToThirdDrop() {
    thirdDropDown.clear();
    for (var element in gsmDataPacks.prepaid[selectedFirstValue.value!.value]
        .subpackages[selectedSecondValue.value!.value].datapackages) {
      int index = gsmDataPacks.prepaid[selectedFirstValue.value!.value]
          .subpackages[selectedSecondValue.value!.value].datapackages
          .indexOf(element);
      thirdDropDown.add(DropdownMenuItem(
          value: CustomMenuDropDown(value: index, title: element.title),
          child: Text(element.title)));
    }
    selectThirdDropDownValue(0);

    notifyListeners();
  }

  selectThirdDropDownValue(int index) {
    selectedThirdValue = thirdDropDown[index];
    notifyListeners();
  }
}
