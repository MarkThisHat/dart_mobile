import 'package:flutter/material.dart';

class LocationRow extends StatelessWidget {
  final String name;
  final String region;
  final String country;
  final String query;

  const LocationRow({
    super.key,
    required this.name,
    required this.region,
    required this.country,
    required this.query,
  });

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
    int matchLength = match.length;

    String actualMatch = text.substring(0, matchLength);
    String afterMatch =
        text.length > matchLength ? text.substring(matchLength) : '';

    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: actualMatch,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: afterMatch),
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
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        return GestureDetector(
          onTap: () => onItemTap(location),
          child: LocationRow(
            name: location['name'],
            region: location['admin1'] ?? 'N/A',
            country: location['country'],
            query: query,
          ),
        );
      },
    );
  }
}
