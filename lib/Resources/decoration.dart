import 'package:flutter/material.dart';
import 'package:think_bot/Resources/resources.dart';

import '../Base/Resizer/fetch_pixels.dart';

class AppDecoration {
  final InputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(FetchPixels.getPixelHeight(10.0)),
    ),
    borderSide: BorderSide(
      color: R.colors.lightGreyColor,
      width: FetchPixels.getPixelHeight(2.0),
    ),
  );

  final InputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(FetchPixels.getPixelHeight(10.0)),
    ),
    borderSide: BorderSide(
      color: R.colors.greyColor,
      width: FetchPixels.getPixelHeight(2.0),
    ),
  );

  final InputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(FetchPixels.getPixelHeight(10.0)),
    ),
    borderSide: BorderSide(
      color: R.colors.redColor,
      width: FetchPixels.getPixelHeight(2.0),
    ),
  );
}
