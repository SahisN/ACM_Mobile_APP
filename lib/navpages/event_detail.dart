import "package:flutter/material.dart";
import 'package:acm_app/model/event_item.dart';
import 'package:acm_app/data/random_number.dart';
import 'package:like_button/like_button.dart';

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
                       Text(
                            event.name,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                      const SizedBox(
                        height: 10,

                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "October 19th, 4:00 p.m",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          //maybe put the time
                        ],
                      ),
                      

                      const SizedBox(height: 30,),
                      Align(alignment: Alignment.centerLeft,
                        child: Text("Description:",
                        
                        style: TextStyle(
                              
                                fontSize: 20,
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      ),

                      const SizedBox(height: 5,),
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
            const Positioned(
              top: 5,
              right: 10,
              child:LikeButton(
                size: 40,
              )
                
                
              
            ) 
          ],
        ),
      ),
    );
  }
}
