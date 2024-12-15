import 'package:flutter/material.dart';
class StudentDetailModel {
  final String name;
  final String location;
  final String roomNumber;
  final String parentTell;
  final String classRoom;

  StudentDetailModel({
    required this.name,
    required this.location,
    required this.roomNumber,
    required this.parentTell,
    required this.classRoom,
  });

  factory StudentDetailModel.fromJson(Map<String, dynamic> json) {
    return StudentDetailModel(
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      roomNumber: json['roomNumber'] ?? '',
      parentTell: json['parentTell'] ?? '',
      classRoom: json['classRoom'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'roomNumber': roomNumber,
      'parentTell': parentTell,
      'classRoom': classRoom,
    };
  }
}