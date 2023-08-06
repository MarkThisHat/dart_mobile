import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../services/api.dart';
import 'dart:async';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) updateText;
  final Color color;

  const SearchField({
    super.key,
    required this.controller,
    required this.updateText,
    required this.color,
  });

  @override
  SearchFieldState createState() => SearchFieldState();
}

class SearchFieldState extends State<SearchField> {
  final BehaviorSubject<String> _searchSubject = BehaviorSubject<String>();
  StreamSubscription<List<Map<String, dynamic>>?>? _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = _searchSubject
        .debounceTime(const Duration(milliseconds: 300))
        .distinct()
        .switchMap((query) => (query.isEmpty
            ? Stream.value(null)
            : searchLocationByName(query).asStream()))
        .listen((locations) {
      if (locations != null) {
        print(locations);
      } else {
        print('No locations');
      }
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
          onSubmitted: (value) {
            widget.updateText(value);
            widget.controller.clear();
          },
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
}
