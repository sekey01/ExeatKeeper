
import 'dart:math';

import 'package:flutter/cupertino.dart';

class KeyFunctions extends ChangeNotifier{
  String AuthKey = '';

  // Generate a random string of 2 letters and 2 digits
  String generateRandomString() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();

    // Generate 2 random letters
    String randomLetters = String.fromCharCodes(Iterable.generate(
        2, (_) => letters.codeUnitAt(random.nextInt(letters.length))));

    // Generate 2 random digits
    String randomDigits = random.nextInt(90).toString().padLeft(2, '0');

    // Combine and shuffle the letters and digits
    String combined = randomLetters + randomDigits;
    List<String> chars = combined.split('')..shuffle(random);
   AuthKey = chars.join();
    return chars.join();
  }



  notifyListeners();
}