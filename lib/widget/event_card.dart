import 'package:acm_app/model/event_item.dart';
import 'package:acm_app/screens/event_detail.dart';
import "package:flutter/material.dart";

class EventCard extends StatelessWidget {
  final EventItem event;

  const EventCard(
    this.event, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      //Column allows for the cards to stack
      child: Column(
        //children allows there to be more than 1 card
        children: [
          //information of 1 card
          Card(
            //parameters for the card
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            color: Theme.of(context).colorScheme.primary,
            //elevates the card and gives a shadow to it.
            elevation: 15,
            shadowColor: Theme.of(context).shadowColor,
            //ListTile is a fixed height row

            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => DetailPage(
                            event: event,
                          )),
                );
              },
              child: Ink(
                child: GestureDetector(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      //this gives the avatar that holds a "!" a char
                      child: const Text(
                        "!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                    title: Text(event.name),
                    subtitle: Text(event.location),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
