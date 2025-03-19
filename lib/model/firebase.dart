//import 'dart:convert';
import 'dart:convert';
//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:acm_app/model/event_item.dart';

String collectionName = "InnoTestEvents";
const String UPDATE_TOPIC = "event_update";
const KEY = "";
const SAVE_PATH = "/acm-app-save.json";

///===== FireStore Docs ==============================
///
/// Getting DateTime: firestore timestamps has a converting
///   function "toDate()" that returns the relvent DateTime object
///
/// _fetchLastest: will query firestore online and store it locally
///
///===================================================

class Database {
  static bool subscribedToMsg = false;
  static Timestamp lastRead = Timestamp(1, 0);
  static Map<DateTime, List<EventItem>> eventMap = {};

  static Future<void> init() async {
    Database.subscribeToEventUpdates();

    return Future(() => null);
  }

  //===== Google Calendar API =============================

  static Future<void> fetchCalendarEvents(
      DateTime minDate, DateTime maxDate) async {
    Uri url = Uri.https("www.googleapis.com",
        "/calendar/v3/calendars/acm.calstatela@gmail.com/events", {
      "key": KEY,
      "singleEvents": "true",
      "maxResults": "2000",
      "minTime": "${minDate.year}-${minDate.month}-${minDate.day}",
      "maxTime": "${maxDate.year}-${maxDate.month}-${maxDate.day}"
    });

    var res = await http.get(url);
    Map<String, dynamic> resJson = jsonDecode(res.body);

    //empty return
    if (resJson.isEmpty || resJson['items'] == null) {
      return;
    }
    eventMap.clear();

    for (Map<String, dynamic> item in resJson["items"]) {
      if (item["kind"] != "calendar#event") continue;

      final eventItem = EventItem.parseJson_googleCal(item);
      final dateOnly = DateUtils.dateOnly(eventItem.dateTime);

      //map a list to a date key if not existed
      if (!Database.eventMap.containsKey(dateOnly)) {
        Database.eventMap.addAll({dateOnly: <EventItem>[]});
      }

      Database.eventMap[dateOnly]!.add(eventItem);
    }

    return Future(() => null);
  }

  //===== Firebase Messaging =============================================

  static void subscribeToEventUpdates() {
    if (subscribedToMsg) return;

    FirebaseMessaging.instance.subscribeToTopic(UPDATE_TOPIC).then((value) {
      subscribedToMsg = true;
      FirebaseMessaging.onMessage.listen(Database._onMsgReceived);
      FirebaseMessaging.onBackgroundMessage(Database._onMsgReceived);
      print("Subscribed!");
    });
  }

  static Future<void> _onMsgReceived(RemoteMessage msg) {
    if (msg.from != "/topics/$UPDATE_TOPIC") {
      //print(msg.from);
      return Future.error(Exception("Wrong Topic!"));
    }

    print("Topic Received!");
    //updateSavedEvents();

    return Future(() => null);
  }

  static void updateSavedEvents() async {
    final db = FirebaseFirestore.instance;

    //offline querry
    final res = await db
        .collection(collectionName)
        .where("latest_date_changed", isGreaterThan: lastRead)
        .get(const GetOptions(source: Source.server));

    if (res.docs.isNotEmpty) {
      (res.docs[0].data()['latest_date_change'] as Timestamp).toString();
    }
  }

  static Future<void> _saveToDrive() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}$SAVE_PATH');
    final List<EventItem> eventList = List<EventItem>.empty();

    for (List<EventItem> itemList in eventMap.values) {
      eventList.addAll(itemList);
    }

    String jsonStr = jsonEncode({"last_read": lastRead, "events": eventList});
    file.writeAsStringSync(jsonStr, mode: FileMode.writeOnly);

    return Future(() => null);
  }
}
