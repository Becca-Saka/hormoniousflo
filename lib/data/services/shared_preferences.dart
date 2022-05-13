import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceService {
  final cyclePath = 'cycle';
  
  saveCycleDate(dynamic cycles) async {
    final data = jsonEncode(cycles);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(cyclePath, data);
  }

  getCycleDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(cyclePath);
    if (data != null) {
      return jsonDecode(data);
    }
  }
}
