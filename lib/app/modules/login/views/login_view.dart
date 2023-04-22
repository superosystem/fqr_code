import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: ListView(
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
                padding: const EdgeInsets.symmetric(vertical: 20)),
            child: const Text("LOGIN"),
          )
        ],
      ),
    );
  }
}
