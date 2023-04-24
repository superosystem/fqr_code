import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({Key? key}) : super(key: key);

  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD PRODUCT'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: "Code",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: nameC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Name",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: qtyC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Quantity",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                if (codeC.text.isNotEmpty &&
                    nameC.text.isNotEmpty &&
                    qtyC.text.isNotEmpty) {
                  controller.isLoading(true);
                  // process login
                  Map<String, dynamic> result = await controller.addProduct({
                    "code": codeC.text,
                    "name": nameC.text,
                    "qty": int.tryParse(qtyC.text) ?? 0,
                  });
                  controller.isLoading(false);
                  if (result["error"] == true) {
                    Get.snackbar(
                      "ERROR",
                      result["message"],
                      duration: const Duration(seconds: 2),
                    );
                  } else {
                    Get.offAllNamed(Routes.home);
                    Get.snackbar(
                      "SUCCESS",
                      result["message"],
                      duration: const Duration(seconds: 2),
                    );
                  }
                } else {
                  Get.snackbar(
                    "ERROR",
                    "All field should not be empty",
                    duration: const Duration(seconds: 2),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20)),
            child: Obx(
              () =>
                  Text(controller.isLoading.isFalse ? "SUBMIT" : "LOADING..."),
            ),
          ),
        ],
      ),
    );
  }
}
