import 'package:flutter/material.dart';
import 'searchrow.dart';

class ListViewOverlay extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults;
  final String currentSearchTerm;

  const ListViewOverlay({
    super.key,
    required this.searchResults,
    required this.currentSearchTerm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.white.withOpacity(0.9), // semi-transparent background
      child: LocationTable(
        locations: searchResults,
        query: currentSearchTerm,
      ),
    );
  }
}
