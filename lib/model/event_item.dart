import 'package:cloud_firestore/cloud_firestore.dart';

class EventItem {
  String name = "";
  String imageURL = "";
  String description = "";
  DateTime dateTime;
  String location;

  EventItem(this.name, this.dateTime, this.description, this.location, this.imageURL);

  //returns a new EventItem from the passed in event json map;
  factory EventItem.parseJson(Map<String, dynamic> json) {
    //type casting
    final name = (json['name'] ?? "event_name") as String;
    final description = (json['description'] ?? "No Description Provided.") as String;
    final location = (json['location'] ?? "somwhere") as String;
    final imageURL = (json['imageUrl'] ?? "") as String;
    final DateTime dateTime = (json['datetime'] as Timestamp).toDate();

    return EventItem(name, dateTime, description, location, imageURL);
  }

  factory EventItem.parseJson_googleCal(Map<String, dynamic> json) {
    //type casting
    final name = (json['summary'] ?? "event_summary") as String;
    final description = (json['description'] ?? "No Description Provided.") as String;
    final location = (json['location'] ?? "somewhere") as String;
    final imageURL = ( (json['attachments'] ?? "") == "" ? "" :  json['attachments'][0]['fileUrl']) as String ;

    //print( (json["start"] as Map<String, dynamic>).entries.toString() );
    final DateTime dateTime =
        DateTime.parse(json["start"]["date"] ?? json["start"]["dateTime"]);

    return EventItem(name, dateTime, description, location, imageURL);
  }
}
