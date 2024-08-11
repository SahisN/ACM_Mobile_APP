//class definition

class EventItem {
  String name = "";
  String description = "";
  String imageURL = "";
  DateTime dateTime;
  String location;
  
  //constructor initializes EventItem
  EventItem(this.name, this.description, this.dateTime, this.location, this.imageURL);

  //returns a new EventItem from the passed in event json map;
  factory EventItem.parseJson(Map<String, dynamic> json) {
    //type casting
    final name = json['event_name'] as String;
    final descript = json['event_description'] as String;
    final location = json['location'] as String;
    final imageURL = json['image_url'] as String;
    final DateTime dateTime = DateTime.parse( json['date_time'] as String );

    return EventItem(name, descript, dateTime, location, imageURL);
  }

  
// comparison to check if the items are the same
  @override
  bool operator ==(Object other) => identical(this, other) || other is EventItem &&
    runtimeType == other.runtimeType && 
    name == other.name &&
    description == other.description &&
    dateTime == other.dateTime &&
    location == other.location &&
    imageURL == other.imageURL;
// hash, no idea but from doc it needs to be added 
// https://api.flutter.dev/flutter/dart-core/Object/hashCode.html
    @override
    int get hashCode =>
      name.hashCode ^ 
      description.hashCode ^
      dateTime.hashCode ^
      location.hashCode ^
      imageURL.hashCode;

}
