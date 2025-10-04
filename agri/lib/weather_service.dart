
// weather_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  static const String API_KEY = "your_openweathermap_api_key_here";
  static const String BASE_URL = "https://api.openweathermap.org/data/2.5";

  static Future<Map<String, dynamic>?> getCurrentWeather(String city) async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/weather?q=$city,IN&appid=$API_KEY&units=metric'),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      return null;
    } catch (e) {
      print('Weather API Error: $e');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getForecast(String city) async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/forecast?q=$city,IN&appid=$API_KEY&units=metric'),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> list = data['list'];

        List<Map<String, dynamic>> forecast = [];
        Map<String, dynamic> dailyForecasts = {};

        for (var item in list) {
          DateTime date = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
          String dateKey = '${date.year}-${date.month}-${date.day}';

          if (!dailyForecasts.containsKey(dateKey) && forecast.length < 5) {
            dailyForecasts[dateKey] = item;
            forecast.add({
              'date': date,
              'temp': item['main']['temp'].round(),
              'description': item['weather'][0]['description'],
              'icon': item['weather'][0]['icon'],
              'humidity': item['main']['humidity'],
              'windSpeed': item['wind']['speed'],
            });
          }
        }

        return forecast;
      }
      return [];
    } catch (e) {
      print('Forecast API Error: $e');
      return [];
    }
  }
}
