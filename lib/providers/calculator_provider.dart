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

  bool isParentheses(String character) {
    return ["(", ")"].contains(character);
  }

  bool isOperator(String character) {
    return ["÷", "×", "-", "+"].contains(character);
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
      case "-":
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
    // stack of parentheses
    List<String> stack = [];
    for(int i = 0; i < _sequence.length; i++) {
      String chr = _sequence[i];
      if(chr.compareTo("(") == 0) {
        stack.add("(");
      } else if(chr.compareTo(")") == 0) {
        if(stack.isEmpty) { // can't pair )
          return false;
        } else if(stack.last.compareTo("(") == 0) {
          // pair of parentheses
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
        // previous character is not )
        if(!(i > 0 && _input[i - 1].compareTo(")") == 0)
          && currentNumber.isNotEmpty
        ) {
          _sequence.add(currentNumber);
          currentNumber = "";
        }
        _sequence.add(chr);
        continue;
      } else if(chr.compareTo("(") == 0) {
        if(i > 0) {
          // ...)(... -> ...)*(...
          if(_input[i - 1].compareTo(")") == 0) {
            _sequence.add("×");
          } else if(currentNumber.isNotEmpty) {
            // ...5(... -> ...5*(...
            _sequence.add(currentNumber);
            _sequence.add("×");
          }
        }
        _sequence.add(chr);
        currentNumber = "";
        continue;
      } else if(i > 0 && _input[i - 1].compareTo(")") == 0
        && isNumber(chr) // previous is ) and current is a number
      ) {
        // ...)5... -> ...)*5...
        _sequence.add("×");
      }
      currentNumber += chr;
    }
    // final number
    if(currentNumber.isNotEmpty) {
      _sequence.add(currentNumber);
    }
  }

  void fixNegativeValues() {
    // first number
    if(_sequence[0].compareTo("-") == 0 && isNumber(_sequence[1])) {
      _sequence.removeAt(0);
      _sequence[0] = "-${_sequence[0]}";
    }
    for(int i = 1; i < _sequence.length - 1; i++) {
      String token = _sequence[i];
      if(token.compareTo("-") == 0) {
        if(isNumber(_sequence[i + 1])) {
          if(isOperator(_sequence[i - 1]) ||
              _sequence[i - 1].compareTo("(") == 0) {
            _sequence.removeAt(i);
            _sequence[i] = "-${_sequence[i]}";
          } else {
            _sequence[i] = "+";
            _sequence[i + 1] = "-${_sequence[i + 1]}";
          }
        } else if(_sequence[i + 1].compareTo("-") == 0) {
          _sequence.removeAt(i + 1);
          if(!isOperator(_sequence[i - 1])) {
            _sequence[i] = "+";
          } else {
            _sequence.removeAt(i);
            i--;
          }
        }
      }
    }
  }

  int precedence(String op){
    // lower precedence
    if(op.compareTo("+") == 0 || op.compareTo("-") == 0) {
      return 1;
    }
    // higher precedence
    if(op.compareTo("×") == 0 || op.compareTo("÷") == 0) {
      return 2;
    }
    return 0;
  }
  // shunting yard algorithm
  void eval() {
    print(_sequence);
    // stack of values
    List<num> values = [];
    // stak of operations
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
      } else { // is operator
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
    fixNegativeValues();
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
    if(_input.compareTo("Error") == 0) {
      clear();
    }
    // first number
    if(_input.compareTo("0") == 0) {
      // can start with -
      if(isOperator(evt)) {
        if(evt.compareTo("-") != 0) {
          return;
        }
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
      // do not allow repeated operators, only -
      if(_input.isNotEmpty && isOperator(_input[_input.length - 1])
          && evt.compareTo("-") != 0) {
        return;
      }
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
    } catch(err, st) {
      print(err);
      print(st);
      _input = "Error";
    } finally {
      notifyListeners();
    }
  }
}