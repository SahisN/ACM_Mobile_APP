import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:acm_app/models/event_item.dart';

class Database {
  static String curMonth = "";
  static Map<String, List<EventItem>> cache = Map();  //<numberMonth-numberDay, EventItem>  might change this

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
      return null;
    }

    if (response.body == 'null') {
      return null;
    }

    //parse into EventItems
    final List<EventItem> eventList = List.empty();
    final json = jsonDecode(response.body) as List<dynamic>;
    json.forEach( (event) { 
      EventItem newItem = EventItem.parseJson(event);
      eventList.add(newItem);
      cache['${newItem.dateTime.month}-${newItem.dateTime.day}'];
    });

    //save to cache


    callback(eventList);
    return eventList;
  }

  static List<EventItem> getEvent(DateTime date) {
    return cache[ "${date.month}-${date.day}" ] as List<EventItem>;
  }

}