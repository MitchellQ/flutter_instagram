import 'package:flutter/material.dart';

const webScreenSize = 600;

class Screen {
  static double width(BuildContext context, {double percentage = 100}) =>
      MediaQuery.of(context).size.width / 100 * percentage;

  static double height(BuildContext context, {double percentage = 100}) =>
      MediaQuery.of(context).size.height / 100 * percentage;

  static bool isWeb(BuildContext context) =>
      MediaQuery.of(context).size.width >= webScreenSize;
}
