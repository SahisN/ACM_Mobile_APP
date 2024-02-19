import "package:flutter/material.dart";
import 'package:acm_app/model/event_item.dart';
import 'package:acm_app/data/random_number.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.event});
  final EventItem event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //The appBar allows the page to return to the calendar page
      //The  Text is just a placeholder, ------ MUST CHANGE THIS -----
      /*
      appBar: AppBar(
        title: const Text(""),
      ),*/
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            //Positioned holds the image and controls apperance
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://picsum.photos/id/${getRandomInteger()}/200/300'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            //controls functionality
            /* 
            need to review over this
             */
            Positioned(
                child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  /*
                  Change the icon to a back 
                  */
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
                  color: Colors.black,
                )
              ],
            )),
            //This positioned holds the content that is found under the image
            Positioned(
                top: 260,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),

                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  //Column will be used to organized the content
                  child: Column(
                    children: [
                      //this row will hold title
                      Row(
                        //will create a space between the title and date row
                        //further changes will be done under child: Container
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            event.name,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            //make custom string to date time
                            //widget.event.dateTime.toString(),
                            "5:00 pm",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            event.location,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20,),
                      Text("Description:",
                      style: TextStyle(
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                      const SizedBox(height: 20,),
                      Text(event.description,
                      style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ],
                  ),
                )),
           /* const Positioned(child: Row(
              bottom:0,
              chi
            )) */
          ],
        ),
      ),
    );
  }
}
