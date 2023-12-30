import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:acm_app/models/event_item.dart';

class Database {
  static fetchByMonth(String month, void Function(List<EventItem>) callback) async {
    final url = Uri.parse('https://acm-mobile-app-9c4b7-default-rtdb.firebaseio.com/events/${month}.json');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json'
      }
    );

    if (response.statusCode != 200) {
      print("Fetching Events Failed with code: ${response.statusCode}");
      return;
    }

    //parse into EventItems
    final List<EventItem> eventList = List.empty();
    final json = jsonDecode(response.body) as List<dynamic>;
    json.forEach( (event) => eventList.add(EventItem.parseJson(event)) );

    callback(eventList);
  }
}