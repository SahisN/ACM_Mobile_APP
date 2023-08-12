import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'ACM First General Meeting\n',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Text('Room Number 27'),
                Spacer(),
                Row(
                  children: [
                    SizedBox(width: 8),
                    Text('8/25/2023'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
