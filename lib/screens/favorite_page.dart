import 'package:acm_app/model/event_item.dart';
import 'package:acm_app/widget/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: const Center(
        child: Text('Favorites empty...'),
      ),
    );
  }
}
*/
final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, List<EventItem>>(
        (ref) => FavoriteNotifier());

class FavoriteNotifier extends StateNotifier<List<EventItem>> {
  FavoriteNotifier() : super([]);
  void add(EventItem event) {
    state = [...state, event];
  }

  void remove(EventItem event) {
    state = state.where((element) => element != event).toList();
  }
}

class FavoritePage extends ConsumerWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text('Favorites empty...'),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return EventCard(favorites[index]);
              },
            ),
    );
  }
}
