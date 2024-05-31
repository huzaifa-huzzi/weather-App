// Define a class to represent weather data
class Current {
  final bool isDaytime; // Whether it's daytime or nighttime
  final String weatherCondition; // Current weather condition

  Current({required this.isDaytime, required this.weatherCondition});
}

// Define a method to get the weather icon path based on temperature, time of day, and weather condition
String getWeatherIconPath(double? temperature, bool isDaytime, String weatherCondition) {
  // Check if temperature is null, and provide a default value if it is
  double temp = temperature ?? 0.0; // Default temperature of 0.0

  // Determine if it's daytime or nighttime
  String timeOfDay = isDaytime ? 'day' : 'night';

  // Define default icon based on time of day
  String defaultIcon = 'assets/icons/$timeOfDay.png';

  // Determine the weather condition and update the icon path accordingly
  switch (weatherCondition) {
    case 'clear':
      return defaultIcon;
    case 'clouds':
      return 'assets/weather/$timeOfDay-cloudy.png';
    case 'rain':
      return 'assets/weather/09d.png';
    case 'snow':
      return 'assets/weather/13n.png.png';
    case 'thunderstorm':
      return 'assets/weather/11d.png.png';
    default:
      return defaultIcon;
  }
}
