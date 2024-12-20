import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const StudentDetailRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'QuickSand',
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                  fontFamily: 'QuickSand',
                color: Colors.grey,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start,
              softWrap: true,
              overflow: TextOverflow.visible,
              maxLines: null, // Allows the text to wrap to the next line
            ),
          ),
        ],
      ),
    );
  }
}