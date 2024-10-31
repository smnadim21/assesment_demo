import 'package:dio/dio.dart';
import 'package:nondito_soft_demo/app/core/base_controller.dart';

import '../../../../global_import.dart';

class LoginController extends BaseController {
  final loginFormKey = GlobalKey<FormState>();

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  RxnString emailError = RxnString();
  RxnString passwordError = RxnString();

  RxnString errorText = RxnString();

  login() async {
    resetError();
    hideKeyBoard();
    if (loginFormKey.currentState?.validate() ?? false) {
      if (!isValidEmail(emailC.text)) {
        emailError.value = "Please insert a valid email";
        return;
      }
      if (!isValidPass(passC.text)) {
        passwordError.value = "Password should be at least 6 characters";
        return;
      }
      startLoader();
      //starting login api calls
      try {
        var data = await api.login(email: emailC.text, password: passC.text);
        stopLoader();
        if (data.isOk) {
          Snack.oK('Login Success');
          Get.offNamed(Routes.HOME);
        }
      } on DioException catch (ex) {
        stopLoader();
        // errorText.value = ex.toString();
        var errorResponse = ex.response!;
        {
          if ((errorResponse.statusCode) == 400) {
            Map resp = errorResponse.data;
            if (resp.containsKey("error")) {
              String error = errorResponse.data['error'];
              Snack.error(error);
              errorText.value = error;
              if ((error).contains("email")) {
                emailError.value = error;
              }
              if ((error).contains("password")) {
                passwordError.value = error;
              }
            }
          }
        }
      }
    }
  }

  resetError() {
    Get.closeAllSnackbars();
    emailError.value = null;
    passwordError.value = null;
    errorText.value = null;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  bool isValidPass(String pass) {
    return pass.length > 6;
  }
}
