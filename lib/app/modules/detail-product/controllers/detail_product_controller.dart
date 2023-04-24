import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailProductController extends GetxController {
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingDelete = false.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> updateProduct(Map<String, dynamic> data) async {
    try {
      await db
          .collection("products")
          .doc(data["id"])
          .update({"name": data["name"], "qty": data["qty"]});

      return {
        "error": false,
        "message": "Product has been updated",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Product can not update, $e",
      };
    }
  }

  Future<Map<String, dynamic>> deleteProduct(String id) async {
    try {
      await db.collection("products").doc(id).delete();

      return {
        "error": false,
        "message": "Product has been deleted",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Product can not delete, $e",
      };
    }
  }
}
