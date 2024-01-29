//import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:http/http.dart' as http;
import 'package:acm_app/model/event_item.dart';

String collectionName = "InnoTestEvents";

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