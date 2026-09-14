import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZenorixStore extends ChangeNotifier {
  List<dynamic> sessions = [];
  bool isLoading = true;

  Future<void> load(String jsonContent) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('zenorix_data')) {
      await prefs.setString('zenorix_data', jsonContent);
    }
    final data = json.decode(prefs.getString('zenorix_data')!);
    sessions = List.from(data['sessions'] ?? []);
    isLoading = false;
    notifyListeners();
  }
}
