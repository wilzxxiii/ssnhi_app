import 'package:google_generative_ai/google_generative_ai.dart';

class MyGemini {
  static String apiKey = 'AIzaSyDmU1Db9tRzorudLbsTfNmiClYACw6uVBk';
  var geminiModel = GenerativeModel(model: 'gemini', apiKey: apiKey);
}
