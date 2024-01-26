//import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:http/http.dart' as http;
import 'package:acm_app/model/event_item.dart';

///===== FireStore Docs ==============================
///
/// Getting DateTime: firestore timestamps has a converting
///   function "toDate()" that returns the relvent DateTime object
/// 
/// 
///
///===================================================

//TODO: local firebase caching, fetch by range

class Database {
  static DateTime lastRead = DateTime(1, 1, 1);

  static Future<List<EventItem>> fetchByRange(DateTime? minDate, DateTime? maxDate) async {
    final db = FirebaseFirestore.instance;
    List<String> localIds = List.empty();
    final idQuerry = await db.collection("semesterEvent").get(const GetOptions(source: Source.cache));
    for (final doc in idQuerry.docs) {
      localIds.add( doc.data()["id"] );
    }

    //online querry
    //will hopefully store in local cache
    final onlineRes = await db.collection("semesterEvent").where( Filter.or(
      Filter("id", whereIn: localIds),
      Filter("lastUpdated", isGreaterThan: lastRead)
    ) ).get(const GetOptions(source: Source.server));

    if (onlineRes.docs.isNotEmpty) {
      lastRead = DateTime.now();
    }

    //offline querry
    final offlineRes = await db.collection("semesterEvent").where(
      "datetime", 
      isGreaterThanOrEqualTo: Timestamp.fromDate(minDate as DateTime),
      isLessThanOrEqualTo: Timestamp.fromDate(maxDate as DateTime)
    ).get(const GetOptions(source: Source.cache));

    return _toEventItems(offlineRes);
  }

  static List<EventItem> _toEventItems(QuerySnapshot<Map<String, dynamic>> res) {
    List<EventItem> eventList = [];
    for (final doc in res.docs) {
      eventList.add( EventItem.parseJson(doc.data()) );
    }

    return eventList;
  }

  //===== test =====
  static Future<List<EventItem>> testFetch() async {
    final db = FirebaseFirestore.instance;

    final res = await db.collection("semesterEvents").get();

    List<EventItem> eventList = [];
    for (final doc in res.docs) {
      eventList.add( EventItem.parseJson(doc.data()) );
    }

    return eventList;
  }

  static void testTimeStamp() async {
    final db = FirebaseFirestore.instance;
    
    final res = await db.collection("pastEvents").doc("86qBaCqngKs8GuM8Hqff").get();
    print("================ TEST =====================");
    print( res.data()?['datetime'].toDate() );
  }

  
}