class EventItem {
  String name = "";
  String imageURL = "";
  //DateTime dateTime;
  //String location;
  
  EventItem(this.name, /*this.dateTime, this.location,*/ this.imageURL);

  //returns a new EventItem from the passed in event json map;
  factory EventItem.parseJson(Map<String, dynamic> json) {
    //type casting
    final name = json['altText'] as String;
    //final location = json['location'] as String;
    final imageURL = json['imgUrl'] as String;
    //final DateTime dateTime = DateTime.parse( json['date_time'] as String );

    return EventItem(name, /*dateTime, location,*/ imageURL);
  }
}