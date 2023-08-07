import 'package:flutter/material.dart';

class FootBar extends StatelessWidget {
  final TabController controller;

  const FootBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Material(
      elevation: 5.0,
      child: Container(
        color: theme.colorScheme.primary,
        child: TabBar(
          controller: controller,
          indicatorColor: theme.colorScheme.onPrimary,
          tabs: const [
            Tab(text: 'Currently', icon: Icon(Icons.cloud_outlined)),
            Tab(text: 'Today', icon: Icon(Icons.calendar_today)),
            Tab(text: 'Weekly', icon: Icon(Icons.date_range)),
          ],
          labelColor: theme.colorScheme.onPrimary,
          unselectedLabelColor: theme.colorScheme.onPrimary.withOpacity(0.5),
        ),
      ),
    );
  }
}
