export 'topbar.dart';
export 'body.dart';
export 'footbar.dart';
export 'bodyoverlay.dart';
export 'weatherdata.dart';
export '../services/api.dart';

typedef UpdateTextCallback = void Function(String?, DisplayTextState);

enum DisplayTextState {
  initial,
  geolocationError,
  apiError,
  submissionError,
  parsingError,
  valid,
}
