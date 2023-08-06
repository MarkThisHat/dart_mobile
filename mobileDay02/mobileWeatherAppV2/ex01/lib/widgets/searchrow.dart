import 'package:flutter/material.dart';

class LocationRow extends StatelessWidget {
  final String name;
  final String region;
  final String country;
  final String query;

  const LocationRow({
    Key? key,
    required this.name,
    required this.region,
    required this.country,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _styledText(name, query),
        const SizedBox(width: 10),
        Text(region),
        const SizedBox(width: 10),
        Text(country),
      ],
    );
  }

  Text _styledText(String text, String match) {
    if (text.toLowerCase().contains(match.toLowerCase())) {
      final parts = text.split(match);
      return Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(text: parts.first),
            TextSpan(
                text: match,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: parts.last),
          ],
        ),
      );
    } else {
      return Text(text);
    }
  }
}

class LocationTable extends StatelessWidget {
  final List<Map<String, dynamic>> locations;
  final String query;

  const LocationTable({
    Key? key,
    required this.locations,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        return LocationRow(
          name: location['name'],
          region: location['admin1'] ?? 'N/A',
          country: location['country'],
          query: query,
        );
      },
    );
  }
}
