import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class EventInfo extends StatelessWidget{
  final String name;
  final String description;
  final DateTime dateTime;
  final String location;

  EventInfo(this.name, this.description, this.dateTime, this.location);

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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            //elevates the card and gives a shadow to it.
            elevation: 15,
            shadowColor: Colors.black,
            //ListTile is a fixed height row

              child:ExpansionTile(
              //this is where the expansion part begins
                leading: CircleAvatar(

                //this gives the avatar that holds a "!" a char
                backgroundColor: Colors.grey,
                child: Text(
                  "!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,

                  ),
                ),
              ),
//This is where the parameters for CircleAvatar end
              title: Text(name),
              subtitle:Text(location),

              backgroundColor: Colors.grey,
              trailing: SizedBox(),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Row(
                  children: <Widget>[
                  Spacer(),
                  Text(description),


                ],
              ),
            ),

          ],
            ),
            ),


        ],
      ),
    );
  }
}
