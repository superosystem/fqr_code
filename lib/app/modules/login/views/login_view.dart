import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController emailC = TextEditingController(
      // For Dev
      text: 'admin@fqrcode.com');
  final TextEditingController passwordC = TextEditingController(
      // For Dev
      text: "admin12345");
  final AuthController authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FQR CODE'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              controller: emailC,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => TextField(
                autocorrect: false,
                controller: passwordC,
                keyboardType: TextInputType.text,
                obscureText: controller.isHidden.value,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isHidden.toggle();
                    },
                    icon: Icon(controller.isHidden.isFalse
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
                    controller.isLoading(true);
                    // process login
                    Map<String, dynamic> result =
                        await authC.login(emailC.text, passwordC.text);
                    controller.isLoading(false);
                    if (result["error"] == true) {
                      Get.snackbar("ERROR", result["message"]);
                    } else {
                      Get.offAllNamed(Routes.home);
                    }
                  } else {
                    Get.snackbar(
                        "ERROR", "email and password can not be empty");
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                  padding: const EdgeInsets.symmetric(vertical: 20)),
              child: Obx(
                () =>
                    Text(controller.isLoading.isFalse ? "LOGIN" : "LOADING..."),
              ),
            )
          ],
        ),
      ),
    );
  }
}
