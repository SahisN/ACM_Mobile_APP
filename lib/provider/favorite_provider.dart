import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:acm_app/model/event_item.dart';

// statenotifier is a class that listens and notifies changes

class FavoriteProvider extends StateNotifier<List<EventItem>>{
// constructor sets the list, empty from the beginning
  FavoriteProvider() : super([]);

//toggleFavorite is a method that will add and remove the events from the list
  void toggleFavorite(EventItem event){
    //if the event is in state then it will remove from list
    if(state.contains(event)){
      state = state.where((e) => e != event).toList();
      }
    //otherwise it will add the event
    else{
      state = [...state,event];
      }    
    }
    // method checks if the event is list of favorites
    bool isFavorite(EventItem event){
      return state.contains(event);
  }
}

//manages the list

  final favoriteProvider = StateNotifierProvider<FavoriteProvider, List<EventItem>>(
    (ref) => FavoriteProvider(),
  );


