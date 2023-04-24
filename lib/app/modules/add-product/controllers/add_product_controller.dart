import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  RxBool isLoading = false.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    try {
      var foundDuplicate = await db.collection("products").where("code", isEqualTo: data["code"]).get();
      if(foundDuplicate.docs.isNotEmpty) {
        return {
          "error": true,
          "message": "Product can not add, cause product code is used",
        };
      }

      var result = await db.collection("products").add(data);
      await db
          .collection("products")
          .doc(result.id)
          .update({"productId": result.id});

      return {
        "error": false,
        "message": "New product has been added",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Product can not add, $e",
      };
    }
  }
}
