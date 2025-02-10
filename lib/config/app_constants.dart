class AppConstants {
  // API Constants
  static const String baseUrl = 'http://desk.csndev.com/api';
  // static const String baseUrl = 'http://192.168.0.81:8080/api';
  static const String login = '$baseUrl/queue-management-login';

  static const String servingTicket =
      '$baseUrl/queue-management-serving-ticket';

  static const String queueTicket = '$baseUrl/queue-management-waiting-ticket';
  static const String headline = '$baseUrl/queue-management-headline';
  static const String promotionalBanner =
      '$baseUrl/queue-management-promotional-slide';

  static const String addIdentifier = '$baseUrl/add-identifier';

  // Hive Box
  static const String authBox = 'authBox';

  // Settings veriable Names
  static const String appLocal = 'appLocal';
  static const String isDarkTheme = 'isDarkTheme';

  // Auth Variable Names
  static const String authToken = 'token';
  static const String userData = 'userData';
  static const String deviceToken = 'deviceToken';
}
