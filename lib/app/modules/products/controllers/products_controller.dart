import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProducts() async* {
    yield* db.collection("products").snapshots();
  }
}
