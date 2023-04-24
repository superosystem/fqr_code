import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  RxBool isLoading = false.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    try {
      var result = await db.collection("products").add(data);
      await db
          .collection("products")
          .doc(result.id)
          .update({"productId": result.id});

      return {
        "error": false,
        "message": "Success, new product added",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Failed, product not added $e",
      };
    }
  }
}
