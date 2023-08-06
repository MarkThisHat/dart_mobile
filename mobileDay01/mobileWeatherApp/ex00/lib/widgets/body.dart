import 'package:flutter/material.dart';

class BodyTabBarView extends StatelessWidget {
  final TabController tabController;

  const BodyTabBarView({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle textStyle =
        TextStyle(fontSize: 24.0, color: theme.colorScheme.onBackground);

    return Container(
      color: theme.colorScheme.background,
      child: TabBarView(
        controller: tabController,
        children: [
          Center(
              child: Text(
            'Currently',
            style: textStyle,
          )),
          Center(
              child: Text(
            'Today',
            style: textStyle,
          )),
          Center(
              child: Text(
            'Weekly',
            style: textStyle,
          )),
        ],
      ),
    );
  }
}
