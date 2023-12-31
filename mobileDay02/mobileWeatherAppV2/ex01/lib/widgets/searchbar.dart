import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../services/api.dart';
import 'widgets.dart';
import 'dart:async';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final UpdateTextCallback updateText;
  final Color color;
  final ValueChanged<List<Map<String, dynamic>>> onSearchResults;
  final ValueChanged<Map<String, dynamic>?> onLocationSelected;

  const SearchField(
      {super.key,
      required this.controller,
      required this.updateText,
      required this.color,
      required this.onSearchResults,
      required this.onLocationSelected});

  @override
  SearchFieldState createState() => SearchFieldState();
}

class SearchFieldState extends State<SearchField> {
  final BehaviorSubject<String> _searchSubject = BehaviorSubject<String>();
  StreamSubscription<List<Map<String, dynamic>>?>? _subscription;
  List<Map<String, dynamic>> _locations = [];

  @override
  void initState() {
    super.initState();

    _subscription = _searchSubject
        .debounceTime(const Duration(milliseconds: 1000))
        .distinct()
        .switchMap((query) => (query.isEmpty
            ? Stream.value(null)
            : searchLocationByName(query).asStream()))
        .listen((locations) {
      if (locations != null) {
        _locations = locations;
      } else {
        _locations = [];
      }
      widget.onSearchResults(_locations);
    });

    widget.controller.addListener(() {
      _searchSubject.add(widget.controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: widget.controller,
          onSubmitted: _handleSubmission,
          cursorColor: widget.color,
          decoration: _buildTextFieldDecoration(widget.color),
          style: TextStyle(fontSize: 16.0, color: widget.color),
        ),
      ),
    );
  }

  InputDecoration _buildTextFieldDecoration(Color color) {
    return InputDecoration(
      hintText: "Search location...",
      hintStyle: TextStyle(fontSize: 16.0, color: color.withOpacity(0.5)),
      filled: false,
      enabledBorder: _outlineInputBorder(color.withOpacity(0.5)),
      focusedBorder: _outlineInputBorder(color),
      prefixIcon: Icon(Icons.search, color: color.withOpacity(0.5)),
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

  @override
  void dispose() {
    _searchSubject.close();
    _subscription?.cancel();
    super.dispose();
  }

  void _handleSubmission(String value) {
    searchLocationByName(value).then((locations) {
      if (locations != null &&
          locations.isNotEmpty &&
          locations[0].containsKey('latitude') &&
          locations[0].containsKey('longitude')) {
        _locations = locations;
        widget.onLocationSelected(_locations[0]);
        widget.updateText(
            "${_locations[0]['latitude']} , ${_locations[0]['longitude']}",
            DisplayTextState.valid);
      } else {
        widget.onLocationSelected(null);
        widget.updateText(value, DisplayTextState.submissionError);
      }
    });

    widget.controller.clear();
  }
}
