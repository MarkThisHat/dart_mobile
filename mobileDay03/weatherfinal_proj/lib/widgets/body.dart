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
        textState.index > DisplayTextState.submissionError.index &&
        segments.length < 5) {
      textState = DisplayTextState.parsingError;
    } else if (segments.length > 3) {
      locationInfo = _pickLocation(segments);
    }
    return Container(
      color: colorScheme.background.withOpacity(0.5),
      child: TabBarView(
        controller: widget.tabController,
        children: [
          _buildTabContent(
              locationInfo, _pickCorrectSegment(segments, 3), textState),
          _buildTabContent(
              locationInfo, _pickCorrectSegment(segments, 4), textState),
          _buildTabContent(
              locationInfo, _pickCorrectSegment(segments, 5), textState),
        ],
      ),
    );
  }

  Widget _buildTabContent(
      String label, String displayText, DisplayTextState textState) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    TextStyle baseStyle = TextStyle(fontSize: 16.0, color: scheme.onBackground);
    TextStyle errorStyle = TextStyle(fontSize: 20.0, color: scheme.error);

    String showText = _getDisplayText(label, displayText, textState);

    if ([DisplayTextState.valid, DisplayTextState.initial]
        .contains(textState)) {
      return Center(
        child: SingleChildScrollView(
          child: Text(
            showText,
            style: baseStyle,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return Center(
        child: Text(
          showText,
          style: errorStyle,
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}

String _getDisplayText(
    String label, String? displayText, DisplayTextState displayState) {
  switch (displayState) {
    case DisplayTextState.initial:
      return 'Welcome to Weather App\nSearch climate\nby location or \nGPS';
    case DisplayTextState.valid:
      return '$label\n$displayText';
    case DisplayTextState.emptySubmission:
      return 'Can\'t look for something on an empty search field';
    case DisplayTextState.geolocationError:
      return 'Geolocation is not available. Please enable it in your App settings.';
    case DisplayTextState.apiError:
      return 'Could not fetch weather information online';
    case DisplayTextState.parsingError:
      return 'Received incomplete data from API';
    case DisplayTextState.submissionError:
      return 'Couldn\'t locate a city named $displayText';
    default:
      return 'An error ocurred';
  }
}

String _pickLocation(List<String> segments) {
  if (segments.length < 2) {
    return '';
  } else if (segments.length == 2) {
    return "${segments[0]}\n${segments[1]}";
  }
  return "${segments[0]}\n${segments[1]}\n${segments[2]}";
}

String _pickCorrectSegment(List<String> segments, int i) {
  if (segments.isEmpty) {
    return '';
  }
  if (segments.length < 5) {
    return segments[0];
  } else if (segments.length == 5) {
    i--;
  }
  return segments[i];
}
