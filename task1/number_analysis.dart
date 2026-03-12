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



/* ===== CONCEPTUAL QUESTIONS (Task 1) ===== */

/*

Question-1: What is the difference between a List<int> and a List<dynamic> in Dart? 
    Why is it usually better to use a typed list like List<int>?

Answer: A List<int> is a type-safe list that can only contain integer values, while a List<dynamic>
    can contain values of any type (strings, booleans, numbers, etc.). Using List<int> is better 
    because it provides type safety - the Dart compiler can catch type errors at compile time 
    rather than runtime. It also enables better IDE support with autocomplete and documentation, 
    and makes the code more self-documenting by clearly stating what type of data the list holds.
    Additionally, typed lists have better performance since Dart doesn't need to perform type 
    checking at runtime.


Question-2: In your findMax() function, why is it important to initialize your 'running maximum' 
    variable to the first element of the list rather than to 0 or to a very small number? 
    What could go wrong with the other approaches?

Answer: Initializing to the first element is important because it guarantees that the initial value 
    is actually present in the list. If we initialize to 0 and the list contains all negative 
    numbers (like [-5, -10, -3]), the function would incorrectly return 0 as the maximum, when 
    the actual maximum is -3. Similarly, initializing to a very small number like -999999 could 
    work for most cases but might fail if the list contains even smaller numbers. Using the first 
    element ensures our initial value is always a valid number from the dataset we're analyzing.



Question-3: Your calculateAverage() function calls calculateSum() internally. What software design 
    principle does this demonstrate, and why is reusing existing functions preferable to 
    duplicating code?

Answer: Reusing existing functions is preferable because it reduces code duplication, making the program easier to maintain
    and less prone to bugs. If there's a bug in the sum calculation, we only need to fix it in one place. 
    It also makes the code more readable - calculateAverage's implementation clearly shows that an average is just the sum divided by count. 
    This modular approach follows the single responsibility principle where each function has one clear purpose.


Question-4: Describe in plain English what the for-in loop syntax does in Dart. How is it different 
    from a traditional for loop with an index? When would you prefer one over the other?

Answer: A for-in loop iterates directly over each element in a collection without needing an index 
    variable. For example, 'for (int number in numbers)' means "take each number from the numbers 
    list one by one and do something with it." A traditional for loop uses an index variable to 
    access elements by position (like numbers[i]). For-in loops are preferred when we need to 
    process each element sequentially and don't need the index value. Traditional for loops are 
    better when we need the index (like when modifying the list while iterating, or when we need 
    to skip elements or iterate backwards).


Question-5. If someone calls your findMax() function with an empty list, what happens? How could you 
    modify the function to handle that case safely?

Answer: Without any safeguards, calling findMax() with an empty list would cause a runtime error 
    when trying to access numbers[0] (the first element) because the list has no elements. 
    I modified the function to handle this safely by adding an if-check at the beginning: 
    if (numbers.isEmpty) { print('Warning'); return 0; }. This checks if the list is empty, 
    prints a helpful warning message, and returns a default value (0) instead of crashing. 
    For even better error handling, we could throw a custom exception or return null, but 
    returning 0 with a warning provides a simple graceful degradation.
*/

