import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Padding SearchBarIcon() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextField(
      enabled: false,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'search student',
        fillColor: Colors.blueGrey.shade100,
        filled: true,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        suffixIcon: IconButton(
          onPressed: () {
          },
          icon: Icon(
            Icons.clear_sharp,
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.deepOrangeAccent,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(10),

          ///borderSide: BorderSide(color: Colors.red),
        ),

        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 10.sp,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.deepOrangeAccent,
            style: BorderStyle.solid,
          ),
        ),
        label: Text('search student'),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 10.spMin),
      ),
      onChanged: (value) {
        /// Trigger rebuild to update search results
      },
    ),
  );
}
