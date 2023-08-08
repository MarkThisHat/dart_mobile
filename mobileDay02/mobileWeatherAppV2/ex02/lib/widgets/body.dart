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

    return Container(
      color: colorScheme.background,
      child: TabBarView(
        controller: widget.tabController,
        children: [
          _buildTabContent('Currently', widget.displayText, colorScheme,
              widget.displayTextState),
          _buildTabContent('Today', widget.displayText, colorScheme,
              widget.displayTextState),
          _buildTabContent('Weekly', widget.displayText, colorScheme,
              widget.displayTextState),
        ],
      ),
    );
  }

  Widget _buildTabContent(String label, String? displayText, ColorScheme scheme,
      DisplayTextState displayState) {
    TextStyle style = TextStyle(fontSize: 28.0, color: scheme.onBackground);
    TextStyle errorStyle = TextStyle(fontSize: 20.0, color: scheme.error);

    if (displayText != null) {
      return (_buildTabContentCenter(label, displayText, style, displayState));
    } else {
      return (_buildTabContentCenter(
          label, displayText, errorStyle, displayState));
    }
  }

  Center _buildTabContentCenter(String label, String? displayText,
      TextStyle style, DisplayTextState displayState) {
    String showText = _getDisplayText(label, displayText, displayState);
    return Center(
      child: Text(
        showText,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  String _getDisplayText(
      String label, String? displayText, DisplayTextState displayState) {
    switch (displayState) {
      case DisplayTextState.valid:
        return '$label\n$displayText';
      case DisplayTextState.geolocationError:
        return 'Geolocation is not available. Please enable it in your App settings.';
      case DisplayTextState.apiError:
        return 'Could not fetch weather information online';
      case DisplayTextState.submissionError:
        return 'Couldn\'t locate $displayText.';
      default:
        return 'An error ocurred.';
    }
  }
}
