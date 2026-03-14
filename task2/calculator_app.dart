// Task 2: Async Calculator App
// Name: MUSAB ASHIK
// ID: ATE/0319/15

import 'dart:async';

// Custom exception class for invalid operations
class InvalidOperationException implements Exception {
  final String message;
  InvalidOperationException(this.message);
  
  @override
  String toString() => 'InvalidOperationException: $message';
}

class Calculator {
  final String name;
  
  // History of calculations
  final List<String> _history = [];
  
  Calculator(this.name);
  
  // Ahrithmetic methods
  double add(double a, double b) {
    double result = a + b;
    _addToHistory('add', a, b, result);
    return result;
  }
  
  double subtract(double a, double b) {
    double result = a - b;
    _addToHistory('subtract', a, b, result);
    return result;
  }
  
  double multiply(double a, double b) {
    double result = a * b;
    _addToHistory('multiply', a, b, result);
    return result;
  }
  
  double divide(double a, double b) {
    if (b == 0) {
      throw ArgumentError('Cannot divide by zero. Division by zero is undefined.');
    }
    double result = a / b;
    _addToHistory('divide', a, b, result);
    return result;
  }

  
  void _addToHistory(String operation, double a, double b, double result) {
    _history.add('$operation($a, $b) = $result');
  }
  
  // Print history
  void printHistory() {
    print('\n--- Calculation History ---');
    if (_history.isEmpty) {
      print('No calculations performed yet.');
    } else {
      for (int i = 0; i < _history.length; i++) {
        print('${i + 1}. ${_history[i]}');
      }
    }
  }
  
  // Async method that simulates delayed computation
  Future<double> computeAsync(double a, double b, String operation) async {
    const delay = Duration(milliseconds: 1500); 
    
    double result;
    
    // Switch statement to call appropriate synchronous method
    switch (operation) {
      case 'add':
        result = add(a, b);
        break;
      case 'subtract':
        result = subtract(a, b);
        break;
      case 'multiply':
        result = multiply(a, b);
        break;
      case 'divide':
        result = divide(a, b);
        break;
      default:
        // Throw custom exception for invalid operations
        throw InvalidOperationException('Unknown operation: "$operation". '
            'Valid operations: add, subtract, multiply, divide');
    }
    
    
    await Future.delayed(delay);
    return result;
  }
  
  // Method that handles async computation with error handling
  Future<void> displayResult(double a, double b, String operation) async {
    try {
      final result = await computeAsync(a, b, operation);
      print('$operation($a, $b) = $result');
    } catch (e) {
      // Error message
      print('Error performing $operation($a, $b): $e');
    }
  }
  
  // Chain operations across a list of values
  Future<double> computeChained(List<double> values, String operation) async {
    if (values.isEmpty) {
      throw ArgumentError('Cannot chain operations on empty list');
    }
    
    double result = values[0];
    
    for (int i = 1; i < values.length; i++) {
      switch (operation) {
        case 'add':
          result = add(result, values[i]);
          break;
        case 'subtract':
          result = subtract(result, values[i]);
          break;
        case 'multiply':
          result = multiply(result, values[i]);
          break;
        case 'divide':
          result = divide(result, values[i]);
          break;
        default:
          throw InvalidOperationException('Unknown operation: $operation');
      }
      await Future.delayed(const Duration(milliseconds: 500)); // Small delay between steps
    }
    
    return result;
  }
}

// Parallel execution demonstration
Future<void> demonstrateParallelExecution(Calculator calc) async {
  print('\n--- Parallel Execution Demo ---');
  
  // Create multiple future operations
  final futures = [
    calc.computeAsync(10, 5, 'add'),
    calc.computeAsync(20, 4, 'subtract'),
    calc.computeAsync(6, 7, 'multiply'),
    calc.computeAsync(15, 3, 'divide'),
  ];
  
  print('Running 4 calculations in parallel (should take ~1.5 seconds total)...');
  final stopwatch = Stopwatch()..start();
  

  final results = await Future.wait(futures);
  
  stopwatch.stop();
  
  print('Results: $results');
  print('Time taken: ${stopwatch.elapsedMilliseconds}ms');
  print('Note: Parallel execution is faster because operations run concurrently '
        'instead of sequentially waiting for each to finish.');
}

void main() async {
  print('=' * 50);
  print('ASYNC CALCULATOR APP');
  print('=' * 50);
  
  // Create calculator instance
  final calc = Calculator('MyScientificCalculator');
  
  print('--- ${calc.name} ---\n');
  
  // Test all operations
  await calc.displayResult(10, 4, 'add');
  await calc.displayResult(10, 4, 'subtract');
  await calc.displayResult(10, 4, 'multiply');
  await calc.displayResult(10, 4, 'divide');
  await calc.displayResult(15, 3, 'divide');
  
  // Test division by zero (error handling)
  print('\n--- Testing Error Handling ---');
  await calc.displayResult(10, 0, 'divide');
  
  // Test invalid operation (custom exception)
  print('\n--- Testing Invalid Operation ---');
  await calc.displayResult(5, 3, 'power');
  
  // calculation history
  print('\n--- History Feature ---');
  calc.printHistory();
  
  // Chain operations
  print('\n--- Chained Operations ---');
  try {
    final chainedResult = await calc.computeChained([10, 5, 2, 3], 'add');
    print('Chained addition of [10, 5, 2, 3] = $chainedResult');
  } catch (e) {
    print('Error in chained operation: $e');
  }
  
  // Parallel execution demonstration
  await demonstrateParallelExecution(calc);
  
  print('\n' + '=' * 50);
  print('All calculations complete!');


  
/* ===== CONCEPTUAL QUESTIONS (Task 2) ===== */
/*
Question-6: What is the difference between a synchronous function and an asynchronous function in Dart? 
    In your Calculator class, why is divide() synchronous while computeAsync() is asynchronous?

Answer: A synchronous function executes completely before returning, blocking further code execution 
    until it completes. An asynchronous function returns a Future immediately and allows other 
    code to run while waiting for its operation to complete. divide() is synchronous because 
    division is a simple, instantaneous CPU operation that doesn't need to wait for anything. 
    computeAsync() is asynchronous because it simulates a network delay using Future.delayed() 
    in a real app, this would represent waiting for a server response or database query, and we 
    don't want to block the UI while waiting.



Question-7: Explain the purpose of the await keyword in Dart. What happens if you forget to use await 
    when calling an async function that returns a Future? What does your program print instead 
    of the result?

Answer: The await keyword pauses execution of the current function until the Future completes, then 
    extracts the actual value from the Future. If you forget await when calling an async function, 
    you get a Future object immediately instead of waiting for the result.The program would continue
    executing immediately without waiting for the calculation to complete.



Question-8: What is the purpose of the try-catch block in your displayResult() method? What would 
    happen if you removed it and then called displayResult(10, 0, 'divide')?

Answer: The try-catch block catches and handles errors gracefully, preventing program crashes. 
    Without it, calling displayResult(10, 0, 'divide') would cause an unhandled exception 
    when divide() throws an ArgumentError. The program would terminate abruptly with a 
    stack trace error message. With try-catch, we catch the error, format a user-friendly 
    message, and the program continues running normally, allowing subsequent operations 
    to execute.



Question-9: Why is it good design to have divide() throw an ArgumentError rather than simply returning 0 
    or printing an error inside the divide() method itself? What principle of function design 
    does this reflect?
    
Answer: Throwing an error rather than returning a fake value or printing internally follows the 
    "fail fast" principle and separation of concerns. The divide() method's responsibility is 
    solely to perform division - it shouldn't decide how to handle errors (whether to print, 
    return a default, or crash). By throwing an error, it lets the calling code decide how 
    to respond.

Question-10: What does the async keyword on main() allow you to do? Could this assignment have been 
     written without making main() async? Explain your answer.

Answer: The async keyword on main() allows us to use await inside it to wait for asynchronous 
     operations to complete. Yes, this assignment could have been written without making 
     main() async, but it would be more complex. Without async/await, we would need to use 
     .then() callbacks to handle Futures.
*/
