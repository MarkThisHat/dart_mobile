import 'package:flutter/material.dart';
import 'geobutton.dart';
import 'searchbar.dart';
import 'widgets.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final UpdateTextCallback updateText;
  final TextEditingController searchController;
  final ValueChanged<List<Map<String, dynamic>>> onSearchResults;
  final ValueChanged<Map<String, dynamic>?> onLocationSelected;

  const TopBar(
      {super.key,
      required this.updateText,
      required this.searchController,
      required this.onSearchResults,
      required this.onLocationSelected});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme scheme = theme.colorScheme;

    return AppBar(
      backgroundColor: scheme.primary,
      elevation: 5.0,
      titleSpacing: 0.0,
      title: Row(
        children: [
          SearchField(
            controller: searchController,
            updateText: updateText,
            color: scheme.onPrimary,
            onSearchResults: onSearchResults,
            onLocationSelected: onLocationSelected,
          ),
          GeoLocationButton(
            updateText: updateText,
            color: scheme.onPrimary,
            onLocationSelected: onLocationSelected,
          ),
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
