import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kodiarytask/models/dynamicDataModel/dynamicDataModel.dart';
import 'package:kodiarytask/screens/customForm/customForm.dart';
import 'package:kodiarytask/screens/dataPackScreen/dataPackScreen.dart';
import 'package:kodiarytask/screens/mapScreen/mapScreen.dart';
import 'package:kodiarytask/services/dataPackServices/dataPackService.dart';
import 'package:kodiarytask/services/dynamicFormServices/dynamicFormServices.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (c) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
              bool status =
                  await ref.read(dataPackServiceProvider).getDataPacks();
              if (context.mounted) {
                Navigator.of(context).pop();
              }
              if (status) {
                // ignore: use_build_context_synchronously
                if (context.mounted) {
                  Navigator.push(context, MaterialPageRoute(builder: (c) {
                    return const DataPackScreen();
                  }));
                }
              }
            },
            title: const Text("Buy Data Packs"),
          ),
          ListTile(
            onTap: () {
              if (context.mounted) {
                Navigator.push(context, MaterialPageRoute(builder: (c) {
                  return const MapScreen();
                }));
              }
            },
            title: const Text("Lets make art in map"),
          ),
          ListTile(
            onTap: () {
              String jsonData = '''
    {
      "title": "My Form",
      "fields": [
        {
          "fieldType": "TextInput",
          "name": "Name"
        },
        {
          "fieldType": "DatetimePicker",
          "name": "Date of Birth"
        },
        {
          "fieldType": "Switch",
          "name": "Subscribe to Newsletter",
          "value": true
        }
      ]
    }
  ''';
              Navigator.push(context, MaterialPageRoute(builder: (c) {
                List<Field> formData = List<Field>.from(
                    jsonDecode(jsonData)['fields']
                        .map((x) => Field.fromJson(x)));
                ref
                    .read(dynamicFormServiceProvider)
                    .makeNecessaryPreps(formData);
                return CustomForm(
                  formData: formData,
                  title: jsonDecode(jsonData)["title"],
                );
              }));
            },
            title: const Text("Make Fields"),
          )
        ],
      ),
    ));
  }
}
