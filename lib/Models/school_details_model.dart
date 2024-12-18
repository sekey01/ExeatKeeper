import 'dart:core';
import 'package:flutter/cupertino.dart';
class SchoolDetailsModel {
  final String userId;
  final String schoolName;
  final String house;
  final String houseName;


  SchoolDetailsModel({
    required this.userId,
    required this.schoolName,
    required this.house,
    required this.houseName,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'schoolName': schoolName,
      'house': house,
      'houseName': houseName,
    };
  }

  factory SchoolDetailsModel.fromJson(Map<String, dynamic> json) {
    return SchoolDetailsModel(
      userId: json['userId'],
      schoolName: json['schoolName'],
      house: json['house'],
      houseName: json['houseName'],
    );
  }
}