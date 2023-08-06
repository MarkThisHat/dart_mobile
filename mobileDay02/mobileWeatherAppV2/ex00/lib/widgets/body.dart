import 'package:flutter/material.dart';

class BodyTabBarView extends StatelessWidget {
  final TabController tabController;
  final String? displayText;

  const BodyTabBarView(
      {super.key, required this.tabController, required this.displayText});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.background,
      child: TabBarView(
        controller: tabController,
        children: [
          _buildTabContent('Currently', displayText, colorScheme),
          _buildTabContent('Today', displayText, colorScheme),
          _buildTabContent('Weekly', displayText, colorScheme),
        ],
      ),
    );
  }

  Widget _buildTabContent(
      String label, String? displayText, ColorScheme scheme) {
    TextStyle style = TextStyle(fontSize: 28.0, color: scheme.onBackground);
    TextStyle errorStyle = TextStyle(fontSize: 20.0, color: scheme.error);

    if (displayText != null) {
      return (_buildTabContentCenter(label, displayText, style));
    } else {
      return (_buildTabContentCenter(label, displayText, errorStyle));
    }
  }

  Center _buildTabContentCenter(
      String label, String? displayText, TextStyle style) {
    String showText = displayText != null
        ? '$label\n$displayText'
        : 'Geolocation is not available, please enable it in your App settings';

    return Center(
      child: Text(
        showText,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
