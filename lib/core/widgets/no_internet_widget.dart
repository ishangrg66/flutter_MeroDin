import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.signal_wifi_off, color: Colors.red),
          Text("No Internet!", style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
