import 'package:flutter/material.dart';

class BodyTabBarView extends StatelessWidget {
  final TabController tabController;
  final String? displayText;

  const BodyTabBarView(
      {super.key, required this.tabController, required this.displayText});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle textStyle =
        TextStyle(fontSize: 28.0, color: theme.colorScheme.onBackground);

    return Container(
      color: theme.colorScheme.background,
      child: TabBarView(
        controller: tabController,
        children: [
          _buildTabContent('Currently', displayText, textStyle),
          _buildTabContent('Today', displayText, textStyle),
          _buildTabContent('Weekly', displayText, textStyle),
        ],
      ),
    );
  }

  Widget _buildTabContent(String label, String? displayText, TextStyle style) {
    return Center(
      child: Text(
        '$label\n$displayText',
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
