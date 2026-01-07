import 'package:flutter/cupertino.dart';

import '../resources/resources.dart';

class AppTextStyle {
  TextStyle regularRobotoDisplay() {
    return TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      color: R.colors.whiteColor,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle boldRobotoDisplay() {
    return TextStyle(
      fontSize: 15,
      fontFamily: 'Roboto',
      letterSpacing: 0.0,
      color: R.colors.whiteColor,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle semiBoldRobotoDisplay() {
    return TextStyle(
      fontSize: 15,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      color: R.colors.whiteColor,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle mediumRobotoDisplay() {
    return TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      letterSpacing: 1,
      color: R.colors.whiteColor,
      fontWeight: FontWeight.w500,
    );
  }
}
