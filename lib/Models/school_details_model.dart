import 'dart:core';
import 'package:flutter/cupertino.dart';
class SchoolDetailsModel {
  final String schoolName;
  final String house;
  final String houseName;


  SchoolDetailsModel({
    required this.schoolName,
    required this.house,
    required this.houseName,
  });

  Map<String, dynamic> toJson() {
    return {
      'schoolName': schoolName,
      'house': house,
      'houseName': houseName,
    };
  }

  factory SchoolDetailsModel.fromJson(Map<String, dynamic> json) {
    return SchoolDetailsModel(
      schoolName: json['schoolName'],
      house: json['house'],
      houseName: json['houseName'],
    );
  }
}