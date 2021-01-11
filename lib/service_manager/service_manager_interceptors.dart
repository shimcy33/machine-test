
import 'package:dio/dio.dart';
import 'package:machine_test/constants/StringConstants.dart';
import 'package:machine_test/constants/common_methods.dart';
import 'package:machine_test/constants/common_widgets.dart';
import '../Utilities/login_model.dart';

class ServiceMangerInterceptors extends Interceptor {
  int maxCharactersPerLine = 500;

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    if (options?.method == "GET") {
      CommonMethods().checkNetworkConnection();
      print("Get method");
    } else {
      print("Post method");
    }
    var header = "";

    print("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
    print("REQUEST[${options?.method}] => PATH: ${options?.path}");
    print("!!!!!!!!!!!!!!!!!!!! Request End !!!!!!!!!!!!!!!!!!!!!");
    return options;
  }

  @override
  Future<dynamic> onResponse(Response response) async {
    print("************** Response Begin ************************");
    print("ResMethodType : [${response?.request?.method}]");
    print(
        "RESPONSE[${response?.statusCode}] => PATH: ${response?.request?.path}");
    if (LoginModel().currentContext != null &&

        response != null) {
      if (response.statusCode != null) {
        // if (response.statusCode == 401) {
        //   String msg =  StringConstants.sessionError;
        //   CommonWidgets().showLoginDialog(LoginModel().currentContext, msg);
        // }
      }
    }

    String responseAsString = response?.data.toString();
    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        print(
            responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      print(response?.data);
    }
    print("************** Response End ************************");
    return response;
  }

  @override
  Future<dynamic> onError(DioError error) async {
    print("#################### Error Begin #########################");
    print(
        "ERROR[${error?.response?.statusCode}] => PATH: ${error?.request?.path}");
    String errorDescription = ""; //CommonMethods().getNetworkError(error);
    print("ERRORDesc [${errorDescription}]");
    if (LoginModel().currentContext != null &&
        error != null) {
      if (error?.response?.statusCode != null) {
        // if (error.response.statusCode == 401) {
        //   String msg = LoginModel().isLangIsArabic
        //       ? StringConstants.sessionErrorArabic
        //       : StringConstants.sessionError;
        //   CommonWidgets().showLoginDialog(LoginModel().currentContext, msg);
        // }
      }
    }
    print("#################### Error End #########################");
    return error;
  }
}
