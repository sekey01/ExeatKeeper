import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


class NotificationProvider extends ChangeNotifier{
  //send message with mNotify
  Future<void> sendSms(String to, String content) async {
    final String url = '${dotenv.env['SMS_URL']}';
    final String apiKey = '${dotenv.env['SMS_API_KEY']}';
    final String toNumber = to;
    final String message = content;
    final  String senderId = 'ExeatKeeper';

    final Uri uri = Uri.parse('$url?key=$apiKey&to=$toNumber&msg=${Uri.encodeComponent(message)}&sender_id=$senderId');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        print('Message sent successfully');
        print('Response: ${response.body}');
      } else {
        print('Failed to send message: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}