import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:acm_app/model/event_item.dart';

///===== FireStore Docs ==============================
///
/// Getting DateTime: firestore timestamps has a converting
///   function "toDate()" that returns the relvent DateTime object
/// 
/// 
///
///===================================================

class Database {

  static fetchByRange(DateTime minDate, DateTime maxDate) {}

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