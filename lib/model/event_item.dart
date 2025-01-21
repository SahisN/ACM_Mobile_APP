import 'package:cloud_firestore/cloud_firestore.dart';

class EventItem {
  String uid = "";
  String name = "";
  String imageURL = "";
  String description = "";
  DateTime dateTime;
  String location;

  EventItem(this.name, this.dateTime, this.description, this.location,
      this.imageURL, this.uid);

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'imageURL': imageURL,
        'description': description,
        'dateTime': dateTime.toIso8601String(),
        'location': location,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EventItem && other.uid == uid;
  }

  factory EventItem.fromJson(Map<String, dynamic> json) => EventItem(
        json['name'] as String? ?? '',
        json['dateTime'] != null
            ? DateTime.parse(json['dateTime'] as String)
            : DateTime.now(), // Default to current date if null
        json['description'] as String? ?? '',
        json['location'] as String? ?? '',
        json['imageUrl'] as String? ?? '',
        json['uid'] as String? ?? '',
      );

  factory EventItem.parseJson(Map<String, dynamic> json) {
    //type casting
    final name = (json['name'] ?? "event_name") as String;
    final description =
        (json['description'] ?? "No Description Provided.") as String;
    final location = (json['location'] ?? "somwhere") as String;
    final imageURL = (json['imageUrl'] ?? "") as String;
    final DateTime dateTime = (json['datetime'] as Timestamp).toDate();

    return EventItem(name, dateTime, description, location, imageURL, '');
  }

  // ignore: non_constant_identifier_names
  factory EventItem.parseJson_googleCal(Map<String, dynamic> json) {
    //type casting
    final name = (json['summary'] ?? "event_summary") as String;
    final description =
        (json['description'] ?? "No Description Provided.") as String;
    final location = (json['location'] ?? "somewhere") as String;
    final imageURL = ((json['attachments'] ?? "") == ""
        ? ""
        : json['attachments'][0]['fileUrl']) as String;

    //print( (json["start"] as Map<String, dynamic>).entries.toString() );
    final DateTime dateTime =
        DateTime.parse(json["start"]["date"] ?? json["start"]["dateTime"]);

    final id = json['id'];

    return EventItem(name, dateTime, description, location, imageURL, id);
  }

  @override
  int get hashCode => uid.hashCode;
}
