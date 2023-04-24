import 'package:flutter/material.dart';
import 'package:fqr_code/app/data/models/product_model.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({Key? key}) : super(key: key);

  final ProductModel product = Get.arguments;
  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // initialize data
    codeC.text = product.code;
    nameC.text = product.name;
    qtyC.text = product.qty.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL PRODUCT'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: QrImage(
                  data: product.code,
                  size: 200.0,
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.number,
            readOnly: true,
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
              if (controller.isLoadingUpdate.isFalse) {
                if (nameC.text.isNotEmpty && qtyC.text.isNotEmpty) {
                  controller.isLoadingUpdate(true);
                  // process login
                  Map<String, dynamic> result = await controller.updateProduct({
                    "id": product.productId,
                    "name": nameC.text,
                    "qty": int.tryParse(qtyC.text) ?? 0,
                  });
                  controller.isLoadingUpdate(false);
                  if (result["error"] == true) {
                    Get.snackbar(
                      "ERROR",
                      result["message"],
                      duration: const Duration(seconds: 2),
                    );
                  } else {
                    Get.back();
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
              () => Text(
                  controller.isLoadingUpdate.isFalse ? "UPDATE" : "LOADING..."),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.defaultDialog(
                title: "DELETE PRODUCT",
                middleText:
                    "Are you sure to delete this product with name ${nameC.text} ?",
                actions: [
                  OutlinedButton(
                    onPressed: () => Get.back(),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Background color
                    ),
                    onPressed: () async {
                      controller.isLoadingDelete(true);
                      // PROCESS: DELETE
                      Map<String, dynamic> result =
                          await controller.deleteProduct(product.productId);
                      controller.isLoadingDelete(false);
                      if (result["error"] == true) {
                        Get.snackbar(
                          "ERROR",
                          result["message"],
                          duration: const Duration(seconds: 2),
                        );
                      } else {
                        Get.back(); // for closing dialog
                        Get.back(); // for back one screen
                        Get.snackbar(
                          "SUCCESS",
                          result["message"],
                          duration: const Duration(seconds: 2),
                        );
                      }
                    },
                    child: Obx(
                      () => controller.isLoadingDelete.isFalse
                          ? const Text("Delete")
                          : Container(
                              padding: const EdgeInsets.all(2),
                              height: 15,
                              width: 15,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1,
                              ),
                            ),
                    ),
                  ),
                ],
              );
            },
            child: const Text(
              "DELETE",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
