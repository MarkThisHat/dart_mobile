import 'package:flutter/material.dart';
import 'searchrow.dart';

class ListViewOverlay extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults;
  final String currentSearchTerm;
  final void Function(Map<String, dynamic>) onItemTap;

  const ListViewOverlay({
    super.key,
    required this.searchResults,
    required this.currentSearchTerm,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 50.0 * searchResults.length,
      color: colorScheme.primaryContainer.withOpacity(0.42),
      child: LocationTable(
        locations: searchResults,
        query: currentSearchTerm,
        onItemTap: onItemTap,
      ),
    );
  }
}
