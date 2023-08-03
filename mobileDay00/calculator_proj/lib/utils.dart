import 'package:math_expressions/math_expressions.dart';

double min(double a, double b) {
  if (a < b) {
    return (a);
  } else {
    return (b);
  }
}

bool isNumeric(String str) {
  return (double.tryParse(str) != null);
}

bool isCharacterOperator(String text) {
  String lastChar = lastCharacter(text);
  List<String> operators = ['+', '-', '*', '/'];

  return (operators.contains(lastChar));
}

bool containsDecimalInLastNumber(String text) {
  List<String> splitText = text.split(RegExp(r'[-+*/]'));

  return (splitText.last.contains('.'));
}

String lastCharacter(String text) {
  return (text.split('').last);
}

String processInput(String text, String value) {
  if (text.length > 15) return (text);

  if (int.tryParse(value) != null) {
    if (text == '0') {
      return (value);
    } else {
      return (text += value);
    }
  }
  if (value == '.') {
    if (lastCharacter(text) != '.' &&
        !containsDecimalInLastNumber(text) &&
        (int.tryParse(lastCharacter(text)) != null)) {
      return (text += value);
    }
  }
  if (isCharacterOperator(value)) {
    if (!isCharacterOperator(lastCharacter(text)) &&
        lastCharacter(text) != '.') {
      return (text += value);
    } else if (value == '-' &&
        lastCharacter(text) != '-' &&
        lastCharacter(text) != '.') {
      return (text += value);
    }
  }
  return (text);
}

String processOutput(text) {
  if (int.tryParse(lastCharacter(text)) == null) {
    return ("Uncomplete expression");
  }
  Parser p = Parser();
  Expression exp = p.parse(text);
  ContextModel cm = ContextModel();
  try {
    double result = exp.evaluate(EvaluationType.REAL, cm);

    if (result.isInfinite) {
      return ("Can't divide by zero");
    }
    String output = result.truncateToDouble() == result
        ? result.truncate().toString()
        : result.toString();
    return (output);
  } catch (e) {
    if (e is Exception) {
      return ("Error: Invalid expression");
    } else {
      return ("Error: ${e.toString()}");
    }
  }
}
