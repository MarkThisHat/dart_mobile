import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function(String) updateText;
  final TextEditingController searchController;

  const TopBar(
      {super.key,
      required this.title,
      required this.updateText,
      required this.searchController});

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
          _buildSearchField(scheme.onPrimary),
          _buildGeoLocationButton(scheme.onPrimary),
          const SizedBox(width: 16.0),
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

  Widget _buildGeoLocationButton(Color color) {
    return IconButton(
      icon: Icon(Icons.location_on, color: color),
      onPressed: () {
        updateText('Geolocation');
      },
    );
  }

  Widget _buildSearchField(Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: _buildSearchTextField(color),
      ),
    );
  }

  Widget _buildSearchTextField(Color color) {
    return TextField(
      controller: searchController,
      onSubmitted: (value) {
        updateText(value);
        searchController.clear();
      },
      cursorColor: color,
      decoration: _buildTextFieldDecoration(color),
      style: TextStyle(fontSize: 16.0, color: color),
    );
  }

  InputDecoration _buildTextFieldDecoration(Color color) {
    return InputDecoration(
      hintText: "Search location...",
      hintStyle: TextStyle(fontSize: 16.0, color: color.withOpacity(0.5)),
      filled: false,
      enabledBorder: _outlineInputBorder(color.withOpacity(0.5)),
      focusedBorder: _outlineInputBorder(color),
    );
  }

  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }
}
