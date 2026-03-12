// Task 1: Number Analysis App.
// Name: MUSAB ASHIK 
// ID: ATE/0319/15

// Find maximum value in a list using manual loop
int findMax(List<int> numbers) {
  // Handle empty list case
  if (numbers.isEmpty) {
    print('Warning: Empty list provided to findMax()');
    return 0;
  }
  
  int max = numbers[0];
  for (int i = 1; i < numbers.length; i++) {
    if (numbers[i] > max) {
      max = numbers[i];
    }
  }
  return max;
}

// Find minimum value in a list using manual loop
int findMin(List<int> numbers) {
  // Handle empty list case
  if (numbers.isEmpty) {
    print('Warning: Empty list provided to findMin()');
    return 0; 
  }
  
  int min = numbers[0];
  for (int i = 1; i < numbers.length; i++) {
    if (numbers[i] < min) {
      min = numbers[i];
    }
  }
  return min;
}

// Calculate sum of all numbers using accumulator pattern
int calculateSum(List<int> numbers) {
  // Handle empty list case
  if (numbers.isEmpty) {
    print('Warning: Empty list provided to calculateSum()');
    return 0; // Return default value
  }
  
  int sum = 0;
  for (int number in numbers) { // Using for-in loop
    sum += number;
  }
  return sum;
}

// Calculate average by reusing calculateSum()
double calculateAverage(List<int> numbers) {
  // Handle empty list case
  if (numbers.isEmpty) {
    print('Warning: Empty list provided to calculateAverage()');
    return 0.0;
  }
  
  int sum = calculateSum(numbers);
  return sum / numbers.length;
}

// Count negative numbers in the list
int countNegatives(List<int> numbers) {
  int count = 0;
  for (int number in numbers) {
    if (number < 0) {
      count++;
    }
  }
  return count;
}

// Sort list using bubble sort algorithm
List<int> bubbleSort(List<int> numbers) {
  // A copy to avoid modifying original list
  List<int> sorted = List.from(numbers);
  
  for (int i = 0; i < sorted.length - 1; i++) {
    for (int j = 0; j < sorted.length - i - 1; j++) {
      if (sorted[j] > sorted[j + 1]) {
        int temp = sorted[j];
        sorted[j] = sorted[j + 1];
        sorted[j + 1] = temp;
      }
    }
  }
  return sorted;
}

// Using built-in methods for comparison
int findMaxBuiltIn(List<int> numbers) {
  return numbers.reduce((a, b) => a > b ? a : b);
}

int findMinBuiltIn(List<int> numbers) {
  return numbers.reduce((a, b) => a < b ? a : b);
}

int calculateSumBuiltIn(List<int> numbers) {
  return numbers.fold(0, (prev, element) => prev + element);
}

void main() {
  // Declare and initialize integers including negatives
  final List<int> numbers = [88, -12, 91, 108, -3, 71, 33, 55, 20, -11];
  
  print('=' * 50);
  print('NUMBER ANALYSIS APP');
  print('=' * 50);
  print('Analyzing list: $numbers\n');
  
  // Call each function and store results
  int maxValue = findMax(numbers);
  int minValue = findMin(numbers);
  int sumValue = calculateSum(numbers);
  double averageValue = calculateAverage(numbers);

  
  print('--- Basic Analysis ---');
  print('Maximum value: $maxValue');
  print('Minimum value: $minValue');
  print('Sum of all numbers: $sumValue');
  print('Average: ${averageValue.toStringAsFixed(2)}\n');
  
  
  int negativeCount = countNegatives(numbers);
  print('--- Bonus Analysis ---');
  print('Count of negative numbers: $negativeCount');

  
  List<int> sortedNumbers = bubbleSort(numbers);
  print('Sorted list (Ascending): $sortedNumbers\n');
  
  
  print('--- Built-in Methods Comparison ---');
  print('Max (built-in): ${findMaxBuiltIn(numbers)}');
  print('Min (built-in): ${findMinBuiltIn(numbers)}');
  print('Sum (built-in): ${calculateSumBuiltIn(numbers)}');
  print('Note: Manual loops vs built-in methods - built-in methods are more concise ');
  print('but manual loops give you more control and understanding of the logic.\n');
  
  // Test with edge cases
  print('--- Edge Case Testing ---');
  print('Testing with all negative numbers:');
  List<int> allNegatives = [-5, -10, -3, -8, -1];
  print('List: $allNegatives');
  print('Max: ${findMax(allNegatives)}');
  print('Min: ${findMin(allNegatives)}');
  
  print('\nTesting with single element:');
  List<int> singleElement = [42];
  print('List: $singleElement');
  print('Max: ${findMax(singleElement)}');
  print('Min: ${findMin(singleElement)}');
  print('Sum: ${calculateSum(singleElement)}');
  print('Average: ${calculateAverage(singleElement).toStringAsFixed(2)}');
  
  
  print('\nTesting with empty list :');
  List<int> emptyList = [];
  findMax(emptyList);
  findMin(emptyList);
  calculateSum(emptyList);
  calculateAverage(emptyList);
  
  print('\n' + '=' * 50);
}
