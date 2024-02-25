import 'package:flutter/material.dart';

class FavoritesDrawer extends StatelessWidget {
  const FavoritesDrawer({super.key, required this.onSelectScreen});

  final void Function(String screenIdentifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8)
                ],
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 48,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(width: 18),
                Text(
                  'Calendar',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('Home Page'),
            onTap: () {
              onSelectScreen('homepage');
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {
              onSelectScreen('favorites');
            },
          ),
        ],
      ),
    );
  }
}
