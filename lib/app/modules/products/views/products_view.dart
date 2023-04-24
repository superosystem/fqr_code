import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../data/models/product_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PRODUCTS'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamProducts(),
        builder: (context, snapProduct) {
          if (snapProduct.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapProduct.data!.docs.isEmpty) {
            return const Center(child: Text("No Product"));
          }
          // collecting data products
          List<ProductModel> allProducts = [];
          for (var element in snapProduct.data!.docs) {
            allProducts.add(ProductModel.fromJson(element.data()));
          }
          return ListView.builder(
            itemCount: allProducts.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              ProductModel product = allProducts[index];

              return Card(
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.detailProduct, arguments: product);
                  },
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Code"),
                            Text("Name"),
                            Text("Qty"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(" : "),
                            Text(" : "),
                            Text(" : "),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.code,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(product.name),
                              Text("${product.qty}"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: QrImage(
                              data: "1234",
                              size: 200.0,
                              version: QrVersions.auto),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
