import 'dart:core';
import 'package:flutter/cupertino.dart';
class SecurityDetailsModel {
String securityName;
String securityPhone;

SecurityDetailsModel({
  required this.securityName,
  required this.securityPhone,
});

factory SecurityDetailsModel.fromJson(Map<String, dynamic> json) {
return SecurityDetailsModel(
securityName: json['securityName'] ?? '',
securityPhone: json['securityPhone'] ?? '',
);
}

Map<String, dynamic> toJson() => {
'securityName': securityName,
'securityPhone': securityPhone,
};
}