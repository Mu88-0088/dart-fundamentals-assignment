// Task 2: Async Calculator App
// This program demonstrates OOP, exception handling, and async programming
// Student Name: [Your Name]
// Student ID: [Your ID]

import 'dart:async';

// Custom exception class for invalid operations (bonus challenge)
class InvalidOperationException implements Exception {
  final String message;
  InvalidOperationException(this.message);
  
  @override
  String toString() => 'InvalidOperationException: $message';
}

class Calculator {
  // Properties
  final String name;
  
  // BONUS: History log of calculations
  final List<String> _history = [];
  
  // Constructor
  Calculator(this.name);
  
  // Synchronous arithmetic methods
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
  
  // Private helper to add to history
  void _addToHistory(String operation, double a, double b, double result) {
    _history.add('$operation($a, $b) = $result');
  }
  
  // BONUS: Print history
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
    const delay = Duration(milliseconds: 1500); // Named constant for clarity
    
    double result;
    
    // Use switch statement to call appropriate synchronous method
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
        // BONUS: Throw custom exception for invalid operations
        throw InvalidOperationException('Unknown operation: "$operation". '
            'Valid operations: add, subtract, multiply, divide');
    }
    
    // Simulate network delay
    await Future.delayed(delay);
    return result;
  }
  
  // Method that handles async computation with error handling
  Future<void> displayResult(double a, double b, String operation) async {
    try {
      final result = await computeAsync(a, b, operation);
      print('$operation($a, $b) = $result');
    } catch (e) {
      // User-friendly error message
      print('Error performing $operation($a, $b): $e');
    }
  }
  
  // BONUS: Chain operations across a list of values
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

// BONUS: Parallel execution demonstration
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
  
  // Wait for all futures to complete
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
  
  // Test all operations with proper error handling
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
  
  // BONUS: Print calculation history
  print('\n--- History Feature ---');
  calc.printHistory();
  
  // BONUS: Chain operations
  print('\n--- Chained Operations ---');
  try {
    final chainedResult = await calc.computeChained([10, 5, 2, 3], 'add');
    print('Chained addition of [10, 5, 2, 3] = $chainedResult');
  } catch (e) {
    print('Error in chained operation: $e');
  }
  
  // BONUS: Parallel execution demonstration
  await demonstrateParallelExecution(calc);
  
  print('\n' + '=' * 50);
  print('All calculations complete!');
}
