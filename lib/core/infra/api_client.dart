import 'dart:convert';

import 'package:http/http.dart';

import '../domain/counter.dart';
import 'current_user.dart';

class ApiClient {
  static const baseUrl =
      'https://smfejswfkqnkqteaofes.supabase.co/functions/v1';

  final currentUser = CurrentUser();

  Future<Counter> getCounter() async {
    final user = await currentUser.get();
    final response = await get(_urlFor('/get-counter'),
        headers: {'Authorization': 'Bearer ${user.accessToken}'});
    return Counter.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<Counter> incrementCounter() async {
    final user = await currentUser.get();
    final response = await post(_urlFor('/increment-counter'),
        headers: {'Authorization': 'Bearer ${user.accessToken}'});

    return Counter.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Uri _urlFor(String path) => Uri.parse('$baseUrl$path');
}
