class EventItem {
  String name = "";
  String description = "";
  String imageURL = "";
  DateTime dateTime;
  String location;
  
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
}