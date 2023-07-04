import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kodiarytask/models/dropDownValueModel/dropDownValueModel.dart';
import 'package:kodiarytask/screens/dataPackScreen/components/components.dart';
import 'package:kodiarytask/services/dataPackServices/dataPackService.dart';

class DataPackScreen extends ConsumerWidget {
  const DataPackScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buy Data Packs"),
      ),
      body: Column(
        children: [
          Consumer(builder: (context, ref, c) {
            final items = ref.watch(dataPackServiceProvider).firstDropDown;
            final value = ref.watch(dataPackServiceProvider).selectedFirstValue;
            return CustomDropDown(
              value: value.value!,
              items: items,
              onChanged: (v) {
                ref
                    .read(dataPackServiceProvider)
                    .selectFirstDropDownValue(v.value);
              },
            );
          }),
          Consumer(builder: (context, ref, c) {
            final items = ref.watch(dataPackServiceProvider).secondDropDown;
            final value =
                ref.watch(dataPackServiceProvider).selectedSecondValue;
            return CustomDropDown(
              value: value.value!,
              items: items,
              onChanged: (v) {
                ref
                    .read(dataPackServiceProvider)
                    .selectSecondDropDownValue(v.value);
              },
            );

            // DropdownButton(
            //     value: value,
            //     items: items,
            //     onChanged: (v) {
            //       ref
            //           .read(dataPackServiceProvider)
            //           .selectSecondDropDownValue(v!);
            //     });
          }),
          Consumer(builder: (context, ref, c) {
            final items = ref.watch(dataPackServiceProvider).thirdDropDown;
            final value = ref.watch(dataPackServiceProvider).selectedThirdValue;
            return CustomDropDown(
              value: value.value!,
              items: items,
              onChanged: (v) {
                ref
                    .read(dataPackServiceProvider)
                    .selectThirdDropDownValue(v.value);
              },
            );
            //  DropdownButton(
            //     value: value,
            //     items: items,
            //     onChanged: (v) {
            //       ref
            //           .read(dataPackServiceProvider)
            //           .selectThirdDropDownValue(v!);
            //     });
          }),
          ElevatedButton(
              onPressed: () {
                final dataPackService = ref.read(dataPackServiceProvider);
                final firstPack = dataPackService
                    .firstDropDown[
                        dataPackService.selectedFirstValue.value!.value]
                    .value!
                    .title;
                final secondPack = dataPackService
                    .secondDropDown[
                        dataPackService.selectedSecondValue.value!.value]
                    .value!
                    .title;
                final thirdPack = dataPackService
                    .thirdDropDown[
                        dataPackService.selectedThirdValue.value!.value]
                    .value!
                    .title;
                print(
                    "FirstPack: $firstPack, SecondPack: $secondPack, ThirdPack:$thirdPack ");
              },
              child: const Text("Show Selected Pack")),
        ],
      ),
    );
  }
}
