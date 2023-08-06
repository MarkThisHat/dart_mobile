import 'package:flutter/material.dart';
import 'geobutton.dart';
import 'searchbar.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function(String?) updateText;
  final TextEditingController searchController;
  final ValueChanged<List<Map<String, dynamic>>> onSearchResults;

  const TopBar({
    super.key,
    required this.title,
    required this.updateText,
    required this.searchController,
    required this.onSearchResults,
  });

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
          _buildTitle(scheme.onPrimary),
          SearchField(
            controller: searchController,
            updateText: updateText,
            color: scheme.onPrimary,
            onSearchResults: onSearchResults,
          ),
          GeoLocationButton(
            updateText: updateText,
            color: scheme.onPrimary,
          ),
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget _buildTitle(Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
