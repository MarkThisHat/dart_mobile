import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.colorScheme.primary,
      elevation: 5.0,
      titleSpacing: 0.0, // This makes the row use the full width of the AppBar.
      title: Row(
        children: [
          _buildTitle(theme),
          _buildSearchField(theme),
          _buildGeoLocationButton(theme),
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }

  Widget _buildTitle(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }

  Widget _buildGeoLocationButton(ThemeData theme) {
    return IconButton(
      icon: Icon(Icons.location_on, color: theme.colorScheme.onPrimary),
      onPressed: () {
        //TODO: implement geolocation
      },
    );
  }

  Widget _buildSearchField(ThemeData theme) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: _buildSearchTextField(theme),
      ),
    );
  }

  Widget _buildSearchTextField(ThemeData theme) {
    return TextField(
      cursorColor: theme.colorScheme.onPrimary,
      decoration: _buildTextFieldDecoration(theme),
      style: TextStyle(fontSize: 16.0, color: theme.colorScheme.onPrimary),
    );
  }

  InputDecoration _buildTextFieldDecoration(ThemeData theme) {
    return InputDecoration(
      hintText: "Search location...",
      hintStyle: TextStyle(
          fontSize: 16.0, color: theme.colorScheme.onPrimary.withOpacity(0.5)),
      filled: false,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: theme.colorScheme.onPrimary.withOpacity(0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
