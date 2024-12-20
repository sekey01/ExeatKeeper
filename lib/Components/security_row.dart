import 'dart:ffi';

import 'package:ek/security_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Padding securityRow( String SecurityName, String SecurityPhone, int Position){ {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(10.r)
),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.sp,
              child: Icon(Icons.security_outlined, size: 30.sp,),
            ),
            //  SizedBox(width: 10.w,),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mr. ${SecurityName}', style: TextStyle(
                    fontFamily: 'QuickSand',
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    fontSize: 15.sp,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),overflow: TextOverflow.ellipsis,),
                  Text( SecurityPhone, style: TextStyle(
                    fontFamily: 'QuickSand',
                      color: Colors.grey,
                      fontSize: 10.sp,
                      letterSpacing: 3
                  ),),
                ],
              ),
            ),

          ],
        ),
      ),
    ),
  );
}
}
