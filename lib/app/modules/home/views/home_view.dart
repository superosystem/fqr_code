import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final AuthController authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FQR CODE'),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: 4,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          late String title;
          late IconData icon;
          late VoidCallback onTap;

          switch (index) {
            case 0:
              title = "Add Product";
              icon = Icons.post_add_rounded;
              onTap = () => Get.toNamed(Routes.addProduct);
              break;
            case 1:
              title = "View Products";
              icon = Icons.list_alt_outlined;
              onTap = () => Get.toNamed(Routes.products);
              break;
            case 2:
              title = "QR Code";
              icon = Icons.qr_code;
              onTap = () => {
                printInfo(info: "OPEN CAMERA")
              };
              break;
            case 3:
              title = "View Catalog";
              icon = Icons.document_scanner_outlined;
              onTap = () => {
                printInfo(info: "OPEN PDF")
              };
              break;
            default:
          }

          return Material(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(9),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      icon,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(title),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic> result = await authC.logout();
          if (result["error"] == false) {
            Get.offAllNamed(Routes.login);
            Get.snackbar("ERROR", result["message"]);
          } else {
            Get.snackbar("ERROR", result["message"]);
          }
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
