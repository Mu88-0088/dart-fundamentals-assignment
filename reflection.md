# Dart Fundamentals Assignment - Reflection

Name:MUSAB ASHIK
ID:ATE/0319/15

#QR1: Most Challenging Concept

The most challenging concept for me was understanding asynchronous programming with Future, async, and await. Initially, I was confused about why we needed these concepts at all - why not just run code sequentially? 

The moment of clarity came when I experimented by removing the `await` keyword from one of the calculator calls. Instead of seeing the calculation result, I saw "Instance of Future<double>" printed. This helped me understand that async functions return immediately with a "promise" of a future value, not the actual value. The real-world analogy of ordering food at a restaurant helped: when you order (call async function), you get a receipt (Future) immediately, but you have to wait (await) for the actual food (result). The kitchen prepares your food while you do other things (non-blocking), and they call your number when it's ready (Future completes).

This understanding clicked when I realized that in mobile apps, this pattern is essential for keeping the UI responsive while fetching data from the internet or database.

# QR2: Data Type Impact Analysis

Looking at my Task 1 solution, if I had to change from `List<int>` to `List<double>`, I would need to change:

1. **Function signatures (4 places)** - All parameters and return types from `int` to `double`
2. **Variable declarations** - The `numbers` list type and all result variables
3. **The `findMax` and `findMin` logic** would still work, but the `max` and `min` variables would need type changes
4. **`calculateAverage`** - Currently returns `double`, which would work fine with `int` input but would be more natural with `double`

Total changes: approximately 8-10 lines of code. This demonstrates why thinking about data types early in design is crucial. If I had anticipated the need for floating-point numbers, I could have designed with `num` type (which accepts both int and double) from the start. This experience taught me that data type decisions early in development can significantly impact future flexibility.

# QR3: Real-World Async Application

In a real Flutter app, a common async operation would be fetching weather data from a web API. For example:

```dart
Future<WeatherData> fetchWeather(String cityName) async {
  final url = Uri.parse('https://api.weather.com/v1/$cityName');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return WeatherData.fromJson(response.body);
  } else {
    throw Exception('Failed to load weather');
  }
}




