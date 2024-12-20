
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

Container  InitContainer(String schoolName,String house, String houseNumber){
  return Container(
    decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(colors: [
          Colors.black, Colors.blueGrey,
        ])
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0,0, 5),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.school_outlined, size: 25.sp,color: Colors.white,),
                      SizedBox(width: 10.w,),
                      Text('$schoolName', overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white, fontSize: 12.sp,fontFamily: 'QuickSand',fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0,0, 5),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.house_outlined, size: 25.sp,color: Colors.white,),
                      SizedBox(width: 10.w,),
                      Text(house, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white, fontSize: 12.sp,fontFamily: 'QuickSand',fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0,0, 5),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.warehouse_outlined, size: 25.sp,color: Colors.white,),
                      SizedBox(width: 10.w,),
                      Text('House : $houseNumber', overflow: TextOverflow.ellipsis,style: const TextStyle(color: Colors.white,fontSize: 12,fontFamily: 'QuickSand',fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),

              ],
            )
        ),


        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Image(image: const AssetImage( 'assets/images/High_School.png'),height: 150.h,width: 150.w,),
          ),),
      ],
    ),
  );
}