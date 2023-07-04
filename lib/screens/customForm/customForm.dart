import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert';

import 'package:kodiarytask/models/dynamicDataModel/dynamicDataModel.dart';
import 'package:kodiarytask/services/dynamicFormServices/dynamicFormServices.dart';

class CustomForm extends ConsumerWidget {
  const CustomForm({super.key, required this.formData, required this.title});
  final List<Field> formData;
  final String title;

  Widget buildFormField(Field field, BuildContext c, WidgetRef ref) {
    switch (field.fieldType) {
      case 'TextInput':
        return Consumer(builder: (context, ref, c) {
          return TextFormField(
            // controller: ref.read(dynamicFormServiceProvider).preps[field.name],
            onChanged: (value) {
              ref
                  .read(dynamicFormServiceProvider)
                  .findInMapAndChangeValue(field.name, value, field.fieldType);
            },
            decoration: InputDecoration(
              labelText: field.name,
            ),
          );
        });
      case 'DatetimePicker':
        return InkWell(
          onTap: () {
            showDatePicker(
              context: c,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            ).then((selectedDate) {
              if (selectedDate != null) {
                // Handle selected date
                ref.read(dynamicFormServiceProvider).findInMapAndChangeValue(
                    field.name, selectedDate, field.fieldType);
              }
            });
          },
          child: IgnorePointer(
            child: TextFormField(
              controller: TextEditingController(
                  text: ref
                      .watch(dynamicFormServiceProvider)
                      .preps[field.name]
                      .toString()
                      .substring(0, 10)),
              // initialValue: ref
              //     .read(dynamicFormServiceProvider)
              //     .preps[field.name]
              //     .toString()
              //     .substring(0, 10),
              decoration: InputDecoration(
                labelText: field.name,
              ),
            ),
          ),
        );
      case 'Switch':
        return Consumer(builder: (context, ref, c) {
          return SwitchListTile(
            title: Text(field.name),
            value: ref.watch(dynamicFormServiceProvider).preps[field.name],
            onChanged: (value) {
              ref
                  .read(dynamicFormServiceProvider)
                  .findInMapAndChangeValue(field.name, value, field.fieldType);
              // Handle switch state change
            },
          );
        });
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: formData.length,
              itemBuilder: (context, index) {
                Field field = formData[index];
                return Padding(
                  padding: EdgeInsets.all(16.0),
                  child: buildFormField(field, context, ref),
                );
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                for (var element in formData) {
                  seeValue(element, ref);
                }
              },
              child: Text("Print value")),
        ],
      ),
    );
  }

  seeValue(Field field, WidgetRef ref) {
    switch (field.fieldType) {
      case "TextInput":
        print(
            "Name : ${ref.read(dynamicFormServiceProvider).preps[field.name].text}");
      default:
        print(
            "Name : ${ref.read(dynamicFormServiceProvider).preps[field.name].toString()}");
    }
  }
}
