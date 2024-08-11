import 'package:acm_app/provider/favorite_provider.dart';
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

/*
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

  void toggleFavorite(EventItem event) {}
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
  
  */


class FavoritePage extends ConsumerWidget{
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    // watches favoriteProvider for changes and sets current state
    final favoriteEvents = ref.watch(favoriteProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: favoriteEvents.isEmpty
        ? const Center(child: Text('No Favorite Event'))
        :ListView.builder(
        itemCount: favoriteEvents.length,
        itemBuilder:(context, index) {
        final event = favoriteEvents[index];
        return EventCard(event);   
      },
    ),
    
    );
  }
}