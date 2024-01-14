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

  static Future<List<EventItem>> fetchByRange(DateTime? minDate, DateTime? maxDate) async {
    final db = FirebaseFirestore.instance;
    final res = await db.collection("semesterEvent").where(
      "datetime", 
      isGreaterThanOrEqualTo: Timestamp.fromDate(minDate as DateTime),
      isLessThanOrEqualTo: Timestamp.fromDate(maxDate as DateTime)
    ).get();

    return _fetch(res);
  }

  static List<EventItem> _fetch(QuerySnapshot<Map<String, dynamic>> res) {
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