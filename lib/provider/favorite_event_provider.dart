import 'package:acm_app/model/event_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:acm_app/user_preferences.dart';

class FavoriteEventNotifier extends StateNotifier<List<EventItem>> {
  FavoriteEventNotifier() : super([]) {
    _loadFavoriteEvents();
  }

  Future<void> _loadFavoriteEvents() async {
    final storedFavorites = await UserPreferences.getFavoriteEvents();
    state = storedFavorites;
  }

  bool toggleFavoriteStatus(EventItem currentEvent) {
    if (state.contains(currentEvent)) {
      state = state.where((event) => event.uid != currentEvent.uid).toList();
      UserPreferences.setFavoriteEvent(state);
      return false;
    } else {
      state = [...state, currentEvent];
      UserPreferences.setFavoriteEvent(state);
      return true;
    }
  }
}

final favoriteEventProvider =
    StateNotifierProvider<FavoriteEventNotifier, List<EventItem>>((ref) {
  return FavoriteEventNotifier();
});
