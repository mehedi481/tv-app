import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalFunction {
  GlobalFunction._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void showCustomSnackbar({
    required String message,
    required bool isSuccess,
    bool isTop = false,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16.r,
        ),
      ),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      dismissDirection:
          isTop ? DismissDirection.startToEnd : DismissDirection.down,
      content: Text(
        message,
        style: TextStyle(fontSize: 12.sp),
      ),
      margin: isTop
          ? EdgeInsets.only(
              bottom: MediaQuery.of(navigatorKey.currentState!.context)
                      .size
                      .height -
                  160,
              right: 20,
              left: 20,
            )
          : null,
    );
    ScaffoldMessenger.of(navigatorKey.currentState!.context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        snackBar,
      );
  }

  static void changeStatusBarTheme({required isDark}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }
}
