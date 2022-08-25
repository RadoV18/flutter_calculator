import 'package:flutter/material.dart';

class CalculatorProvider with ChangeNotifier {
  String _input = "0";
  List _sequence = [];
  bool isDotPressed = false;

  String get input => _input;

  void clear() {
    _sequence = [];
    _input = "0";
    isDotPressed = false;
  }

  bool isOperator(String character) {
    return ["÷", "×", "−", "+"].contains(character);
  }

  num calc(num a, num b, String operator) {
    switch(operator) {
      case "÷":
        if(b == 0) {
          throw Error();
        }
        return a / b;
      case "×":
        return a * b;
      case "−":
        return a - b;
      case "+":
        return a + b;
    }
    throw Error();
  }

  bool isNumber(String s) {
    try {
      num.parse(s);
      return true;
    } catch (err) {
      return false;
    }
  }

  bool isValid() {
    List<String> stack = [];
    for(int i = 0; i < _sequence.length; i++) {
      String chr = _sequence[i];
      if(chr.compareTo("(") == 0) {
        stack.add("(");
      } else if(chr.compareTo(")") == 0) {
        if(stack.isEmpty) {
          return false;
        } else if(stack.last.compareTo("(") == 0) {
          stack.removeLast();
        }
        // empty if previous is (
        if(_sequence[i - 1].compareTo("(") == 0) {
          return false;
        }
      }
    }
    return stack.isEmpty;
  }

  void generateSequence() {
    String currentNumber = "";
    for(int i = 0; i < _input.length; i++) {
      String chr = _input[i];
      if(isOperator(chr) || chr.compareTo(")") == 0) {
        if(!(i > 0 && _input[i - 1].compareTo(")") == 0)) {
          if(currentNumber.isNotEmpty) {
            _sequence.add(currentNumber);
            currentNumber = "";
          }
        }
        _sequence.add(chr);
        continue;
      } else if(chr.compareTo("(") == 0) {
        if(i > 0) {
          if(_input[i - 1].compareTo(")") == 0) {
            _sequence.add("×");
          }
        }
        _sequence.add(chr);
        currentNumber = "";
        continue;
      }
      currentNumber += chr;
    }
    if(currentNumber.isNotEmpty) {
      _sequence.add(currentNumber);
    }
  }

  int precedence(String op){
    if(op.compareTo("+") == 0 || op.compareTo("-") == 0) {
      return 1;
    }
    if(op.compareTo("×") == 0 || op.compareTo("÷") == 0) {
      return 2;
    }
    return 0;
  }
  // shunting yard algorithm
  void eval() {
    List<num> values = [];
    List<String> operations = [];

    void solve() {
      num val2 = values.last;
      values.removeLast();
      num val1 = values.last;
      values.removeLast();
      String op = operations.last;
      operations.removeLast();
      values.add(calc(val1, val2, op));
    }

    for(int i = 0; i < _sequence.length; i++) {
      var token = _sequence[i];
      if(token.compareTo("(") == 0) {
        operations.add(token);
      } else if(isNumber(token)) {
        values.add(num.parse(token));
      } else if(token.compareTo(")") == 0) {
        while(operations.isNotEmpty && operations.last.compareTo("(") != 0) {
          solve();
        }
        if(operations.isNotEmpty) {
          operations.removeLast();
        }
      } else {
        while(operations.isNotEmpty && (precedence(operations.last)
          >= precedence(token))) {
          solve();
        }
        operations.add(token);
      }
    }
    while(operations.isNotEmpty) {
      solve();
    }

    _input = values.last.toString();
  }

  void process() {
    generateSequence();
    if(!isValid()) {
      throw Error();
    }
    eval();
    _sequence = [];
  }

  void deleteLast() {
    if(_input.compareTo("Error") == 0) {
      clear();
      return;
    }
    if(_input.length > 1) {
      String last = _input[_input.length - 1];
      if(last.compareTo(".") == 0) {
        isDotPressed = false;
      }
      _input = _input.substring(0, _input.length - 1);
    } else {
      clear();
    }
  }

  void addCharacter(String evt) {
    // first number
    if(_input.compareTo("0") == 0) {
      if(isOperator(evt)) {
        return;
      }
      if(evt.compareTo(".") != 0) {
        _input = "";
      }
    }
    // dot
    if(evt.compareTo(".") == 0) {
      // repeated dot on the same number
      if(isDotPressed) {
        return;
      } else {
        // 0. after operator
        if(isOperator(_input[_input.length - 1])) {
          _input += "0";
        }
        isDotPressed = true;
      }
    }
    // allow . after operator
    if(isOperator(evt)) {
      isDotPressed = false;
    }
    _input += evt;
  }

  void setInput(String evt) {
    try {
      switch(evt) {
        case "AC":
          clear();
          break;
        case "":
          deleteLast();
          break;
        case "=":
          process();
          break;
        default:
          addCharacter(evt);
      }
    } catch(err) {
      _input = "Error";
    } finally {
      notifyListeners();
      print(_input);
    }
  }
}