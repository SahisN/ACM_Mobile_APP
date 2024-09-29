import 'package:acm_app/model/event_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteEventNotifier extends StateNotifier<List<EventItem>> {
  FavoriteEventNotifier() : super([]);

  bool toggleFavoriteStatus(EventItem currentEvent) {
    if (state.contains(currentEvent)) {
      state = state.where((event) => event.uid != currentEvent.uid).toList();
      return false;
    } else {
      state = [...state, currentEvent];
      return true;
    }
  }
}

final favoriteEventProvider =
    StateNotifierProvider<FavoriteEventNotifier, List<EventItem>>((ref) {
  return FavoriteEventNotifier();
});
