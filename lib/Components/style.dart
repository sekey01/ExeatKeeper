import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle boldTextStyle(Color colour) {
  return TextStyle(

      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: colour,
      letterSpacing: 2
  );
}

TextStyle smallTextStyle(Color colour) {
  return TextStyle(

    fontFamily: 'QuickSand',
      fontSize: 12,
      color: colour,
      letterSpacing: 2,
  );
}
TextStyle moderateBoldTextStyle(Color colour) {
  return TextStyle(
      fontFamily: 'QuickSand',
      fontWeight: FontWeight.bold,
      fontSize: 12.sp,
      color: colour,
      letterSpacing: 2
  );
}
TextStyle smallBoldTextStyle(Color colour) {
  return TextStyle(
      fontFamily: 'Trojan',
      fontWeight: FontWeight.normal,
      fontSize: 10.sp,
      color: colour,
      letterSpacing: 2
  );
}