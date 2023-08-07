import 'package:flutter/material.dart';

class LocationRow extends StatelessWidget {
  final String name;
  final String? region;
  final String country;
  final String query;

  const LocationRow({
    super.key,
    required this.name,
    this.region,
    required this.country,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;

    List<Widget> widgets = [];

    widgets.add(_styledText(name, query));

    if (region != null && region!.isNotEmpty) {
      widgets.addAll([
        const Text(", "),
        const SizedBox(width: 4),
        Text(region!),
      ]);
    }

    widgets.addAll([
      const Text(", "),
      const SizedBox(width: 4),
      Text(country),
    ]);

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 4, 4, 4),
      child: DefaultTextStyle(
        style: TextStyle(
          color: scheme.onPrimaryContainer,
          fontSize: 16.0,
        ),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: Row(children: widgets)),
      ),
    );
  }

  Text _styledText(String text, String match) {
    int matchLength = match.length;

    String actualMatch = text.substring(0, matchLength);
    String afterMatch =
        text.length > matchLength ? text.substring(matchLength) : '';

    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: actualMatch,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
          TextSpan(text: afterMatch, style: const TextStyle(fontSize: 20.0)),
        ],
      ),
    );
  }
}

class LocationTable extends StatelessWidget {
  final List<Map<String, dynamic>> locations;
  final String query;
  final void Function(Map<String, dynamic>) onItemTap;

  const LocationTable({
    super.key,
    required this.locations,
    required this.query,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        return GestureDetector(
          onTap: () => onItemTap(location),
          child: SizedBox(
            height: 48,
            child: LocationRow(
              name: location['name'],
              region: location['admin1'] ?? 'N/A',
              country: location['country'],
              query: query,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(
        height: 1,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
