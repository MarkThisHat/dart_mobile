import 'package:flutter/material.dart';

class ListViewOverlay extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults;

  const ListViewOverlay({super.key, required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.white.withOpacity(0.9), // semi-transparent background
      child: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final result = searchResults[index];
          print(result);
          // Customize your ListTile design
          return ListTile(
            title: Text(
                '${result["name"] ?? ""}, ${result["admin1"] ?? ""}, ${result["country"] ?? ""}'), // example key
            onTap: () {
              // Handle tap action, like navigating to the selected location's details
            },
          );
        },
      ),
    );
  }
}
