import 'widgets.dart';
import 'package:flutter/material.dart';

class BodyTabBarView extends StatefulWidget {
  final TabController tabController;
  final String? displayText;
  final DisplayTextState displayTextState;

  const BodyTabBarView(
      {super.key,
      required this.tabController,
      required this.displayText,
      required this.displayTextState});

  @override
  BodyTabBarViewState createState() => BodyTabBarViewState();
}

class BodyTabBarViewState extends State<BodyTabBarView> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    String? showText = widget.displayText;
    DisplayTextState textState = widget.displayTextState;
    String locationInfo = '';
    List<String> segments =
        (showText ?? "").split('|').where((s) => s.isNotEmpty).toList();

    if (showText != null &&
        textState != DisplayTextState.initial &&
        segments.length != 6) {
      textState = DisplayTextState.parsingError;
    } else if (segments.length > 3) {
      locationInfo = _pickLocation(segments);
    }
    return Container(
      color: colorScheme.background,
      child: TabBarView(
        controller: widget.tabController,
        children: [
          _buildTabContent(locationInfo),
          _buildTabContent(locationInfo),
          _buildTabContent(locationInfo),
        ],
      ),
    );
  }

  Widget _buildTabContent(String label) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    TextStyle baseStyle = TextStyle(fontSize: 28.0, color: scheme.onBackground);
    TextStyle errorStyle = TextStyle(fontSize: 20.0, color: scheme.error);
    TextStyle style = widget.displayText != null ? baseStyle : errorStyle;

    String showText =
        _getDisplayText(label, widget.displayText, widget.displayTextState);

    return Center(
      child: Text(
        showText,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}

String _getDisplayText(
    String label, String? displayText, DisplayTextState displayState) {
  switch (displayState) {
    case DisplayTextState.initial:
      return 'Welcome to Weather App V2';
    case DisplayTextState.valid:
      return '$label\n$displayText';
    case DisplayTextState.geolocationError:
      return 'Geolocation is not available. Please enable it in your App settings.';
    case DisplayTextState.apiError:
      return 'Could not fetch weather information online';
    case DisplayTextState.parsingError:
      return 'Received incomplete data from API';
    case DisplayTextState.submissionError:
      return 'Couldn\'t locate $displayText.';
    default:
      return 'An error ocurred.';
  }
}

String _pickLocation(List<String> segments) {
  return "${segments[0]}\n${segments[1]}\n${segments[2]}";
}
