import 'package:flutter/material.dart';
import 'package:kodiarytask/models/dropDownValueModel/dropDownValueModel.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final CustomMenuDropDown value;
  final List<DropdownMenuItem<CustomMenuDropDown>> items;
  final Function(CustomMenuDropDown) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      // width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CustomMenuDropDown>(
            isExpanded: true,
            value: value,
            items: items,
            onChanged: (v) {
              onChanged(v!);
            }),
      ),
    );
  }
}
