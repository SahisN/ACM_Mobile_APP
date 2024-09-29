//import 'dart:convert';
import 'dart:convert';
//import 'dart:html';
import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:acm_app/model/event_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

String collectionName = "InnoTestEvents";
const String UPDATE_TOPIC = "event_update";
const KEY = "AIzaSyCTyxLBkRIG6bVq9q_KHydsQ_iJ2y8RZZE";
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
  static bool isEventsLoaded = false;
  static bool subscribedToMsg = false;
  static Timestamp lastRead = Timestamp(1, 0);
  static Map<DateTime, List<EventItem>> eventMap = {};

  static Future<void> init() async {
    /*
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}$SAVE_PATH');

    //read save file
    Map<String, dynamic> json = jsonDecode( file.readAsStringSync() );
    lastRead = (json['last_read'] ?? lastRead) as Timestamp;
    final eventList = (json['events'] ?? []) as List< Map<String, dynamic> >;

    //parse read json events into eventMap
    for (Map<String, dynamic> eventJson in eventList) {
      EventItem item = EventItem.parseJson(eventJson);

      //add current date as a new DateTime(key)-List<EventTiem>(value) pair
      if (!eventMap.containsKey(item.dateTime)) {
        eventMap.addAll({ item.dateTime: [item] });
      }
      //add to existing list
      else {
        eventMap[item.dateTime]?.add(item);
      }
    }
    */
    Database.subscribeToEventUpdates();

    return Future(() => null);
  }

  //===== Google Calendar API =============================

  //retreives google calendar events from ACM calendar
  static Future<void> fetchCalendarEvents( DateTime minDate, DateTime maxDate ) async {
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


    if (resJson.isEmpty || resJson['items'] == null) {
      print("request returned emptied");
      return;
    }
    if (isEventsLoaded) {
      eventMap.clear();
    }

    for (Map<String, dynamic> item in resJson["items"]) {
      if (item["kind"] != "calendar#event") continue;

      final eventItem = EventItem.parseJson_googleCal(item);
      DateTime dateKey = DateTime(eventItem.dateTime.year, eventItem.dateTime.month, eventItem.dateTime.day);
      //map a list to a date key if not existed
      if (!Database.eventMap.containsKey(dateKey)) {
        Database.eventMap.addAll({dateKey: <EventItem>[]});
      }

      Database.eventMap[dateKey]!.add(eventItem);
      //print( eventMap[eventItem.dateTime] );
    }

    await cache();

    return Future(() => null);
  }

  //loads from cache, return true if loaded
  /* Event json 
  *   [
        {
          name: string,
          description: string,
          location: imageUrl,
          datetime: ISO
        }
      ]
  *
  */
  static Future<bool> loadEventsFromCache() async {
    if (isEventsLoaded) {
      //clears current events in memory
      Database.eventMap.clear();
      isEventsLoaded = false;
    }

    final SharedPreferences pref = await SharedPreferences.getInstance();
    final jsonStr = await pref.getString('events') ?? "";

    if (jsonStr == "") {
      print("Empty cache");
      return false;
    }

    //parse current event
    final List< dynamic > jsonObj = jsonDecode(jsonStr);

    for (final event in jsonObj) {
      final eventItem = EventItem.parseJson( jsonDecode(event as String) );

      //map a list to a date key if not existed
      if (!Database.eventMap.containsKey(eventItem.dateTime)) {
        Database.eventMap.addAll({eventItem.dateTime: <EventItem>[]});
      }

      Database.eventMap[eventItem.dateTime]!.add(eventItem);
    }

    isEventsLoaded = true;
    return true;
    
    
    //lastRead = Timestamp.fromDate( DateTime.parse(jsonObj["last_read"] as String) );
    
    //----- Used with watch notification -----------------
    //check lastest date with firebase doc date
    //final db = FirebaseFirestore.instance;
    /*
    final res = await db.collection(collectionName).where(
      "latest_date_change",
      isGreaterThan: lastRead
    ).get(const GetOptions(source: Source.server));
    */

    //if server doc date greater return false
    /*
    if (res.docs.isEmpty) {
      return false;
    }
    */

    //else return true and parse into eventItems
    //return true;
  }


  //Save to Cache
  static Future<void> cache() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final eventList = [];

    for (final entry in eventMap.entries) {
      for (final event in entry.value) {
        eventList.add(event.toJson());
      }
    }

    pref.setString("events", jsonEncode(eventList));
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
    if (msg.from != "/topics/" + UPDATE_TOPIC) {
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

  //===== test =====
  static Future<List<EventItem>> testFetch() async {
    final db = FirebaseFirestore.instance;

    final res = await db.collection("semesterEvents").get();

    List<EventItem> eventList = [];
    for (final doc in res.docs) {
      eventList.add(EventItem.parseJson(doc.data()));
    }

    return eventList;
  }

  static void testTimeStamp() async {
    final db = FirebaseFirestore.instance;

    final res =
        await db.collection("pastEvents").doc("86qBaCqngKs8GuM8Hqff").get();
    print("================ TEST =====================");
    print(res.data()?['datetime'].toDate());
  }
}

/*
  static Future<List<EventItem>> fetchByDay(DateTime? day) async {
    final db = FirebaseFirestore.instance;

    _fetchLatest();

    //DateTime(day!.year, day.month, day.day,);

    //offline query
    final offRes = await db.collection(collectionName).where(
      "datetime",
      isGreaterThanOrEqualTo: DateTime(day!.year, day.month, day.day,),
      isLessThan: DateTime(day!.year, day.month, day.day+1,) 
    ).get(const GetOptions(source: Source.cache));

    print( "[OFFLINE] : " + offRes.docs.length.toString() + " items" );

    return _toEventItems(offRes);
  }

  static Future<List<EventItem>> fetchByRange(DateTime? minDate, DateTime? maxDate) async {
    final db = FirebaseFirestore.instance;
    
    _fetchLatest();
    
    //offline querry
    final offlineRes = await db.collection(collectionName).where(
      "datetime", 
      isGreaterThanOrEqualTo: Timestamp.fromDate(minDate as DateTime),
      isLessThanOrEqualTo: Timestamp.fromDate(maxDate as DateTime)
    ).get(const GetOptions(source: Source.cache));

    print( "[OFFLINE] : " + offlineRes.docs.length.toString() + " items" );

    return _toEventItems(offlineRes);
  }

  static List<EventItem> _toEventItems(QuerySnapshot<Map<String, dynamic>> res) {
    List<EventItem> eventList = [];
    for (final doc in res.docs) {
      eventList.add( EventItem.parseJson(doc.data()) );
    }

    return eventList;
  }


  static void _fetchLatest() async {
    final db = FirebaseFirestore.instance;
    /*
    List<String> localIds = ["dummy"];
    final idQuerry = await db.collection(collectionName).get(const GetOptions(source: Source.cache));
    for (final doc in idQuerry.docs) {
      localIds.add( doc.data()["id"] );
    }*/

    //online querry
    //will hopefully store in local cache
    final onlineRes = await db.collection(collectionName).where(
      "lastupdated",
      isGreaterThan: Timestamp.fromDate(lastRead)
    ).get(const GetOptions(source: Source.server));

    if (onlineRes.docs.isNotEmpty) {
      lastRead = DateTime.now();
      print("[ONLINE] : " + onlineRes.docs.length.toString() + " items");
    }
  }
  */
