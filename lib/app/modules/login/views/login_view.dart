import 'package:flutter/foundation.dart';

import 'package:nondito_soft_demo/global_import.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLocal = RxBool(controller.offlineData.isTestDB());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageContainer(
        color: Get.isDarkMode ? LocalColors.BACKGROUND_Dark : LocalColors.BACKGROUND,
        controller: controller,
        child: Stack(
          children: [
            Form(
              key: controller.loginFormKey,
              child: Column(
                children: [
                  const Spacer(
                    flex: 25,
                  ),
                  // Logo Here
                  Row(
                    children: [
                      const Spacer(
                        flex: 50,
                      ),
                      Expanded(
                          flex: 300, child: Image.asset("nondito.png".asset)),
                      const Spacer(
                        flex: 50,
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 32,
                  ),
                  //Welcome
                  const Column(
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          color: Color(0xFF575757),
                          fontSize: 34,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      Text(
                        'Login to continue',
                        style: TextStyle(
                          color: Color(0xFF575757),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      )
                    ],
                  ),
                  const Spacer(
                    flex: 32,
                  ),
                  //Email and Password
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx(
                          () => Visibility(
                              visible: controller.errorText.value != null,
                              child: Column(
                                children: [
                                  AlertText.danger(
                                      alertText:
                                          "${controller.errorText.value}")
                                ],
                              )),
                        ),
                        //Email
                        Obx(() {
                          return ThemeTextField(
                            isRequired: true,
                            hideAsterisk: true,
                            labelText: "Email",
                            hintText: "Email",
                            textEditingController: controller.emailC,
                            errorText: controller.emailError.value,
                            // focusNode: controller.emailNode,
                          );
                        }),
                        //Password
                        Obx(() => ThemeTextField(
                              textEditingController: controller.passC,
                              isRequired: true,
                              hideAsterisk: true,
                              labelText: "Password",
                              obscureText: true,
                              //focusNode: controller.passNode,
                              errorText: controller.passwordError.value,
                            )),
                        const ColumnSpace(),
                        //LoginButton
                        ThemeButton(
                          onPressed: () {
                            controller.login();
                          },
                          text: "Login",
                        ),
                        const ColumnSpace(),
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 32,
                  ),
                  Text(
                    'NonditoSoft demo',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6000000238418579),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  // Create account
                  InkWell(
                    onTap: () {
                      // controller.resetController();
                      //  Get.to(() => const CreateAccountView());
                    },
                    child: const Text(
                      'v1.0.0',
                      style: TextStyle(
                        color: AppColor.colorPrimary,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
