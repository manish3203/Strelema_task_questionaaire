import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/question.dart';
import '../models/questionnaire.dart';

class ApiService extends GetxService {
  final String baseUrl = 'https://69dd0ee184f912a26404b6d0.mockapi.io'; // ← replace

  Future<bool> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return response.statusCode == 201;
  }

 Future<Map<String, dynamic>?> login(String email, String password) async {
  try {
    final uri = Uri.parse('$baseUrl/users').replace(
      queryParameters: {
        'email': email,
        'password': password,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final dynamic decoded = jsonDecode(response.body);

      if (decoded is List) {
        if (decoded.isNotEmpty) {
          // Return the first matching user
          return decoded.first as Map<String, dynamic>;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    rethrow; // ← let controller catch it if you want the snackbar
  }
}

  Future<List<Questionnaire>> getQuestionnaires() async {
  final response = await http.get(Uri.parse('$baseUrl/questionnaires'));

  if (response.statusCode == 200) {
    final List<dynamic> rawList = jsonDecode(response.body);

    return rawList.map((item) {
      // Parse the 'questions' string into List<dynamic>
      final String questionsStr = item['questions'] as String;
      final List<dynamic> questionsJson = jsonDecode(questionsStr);

      // Convert to your Question model
      final List<Question> questions = questionsJson.map((qMap) {
        return Question(
          id: qMap['id'] as String,
          text: qMap['text'] as String,
          options: List<String>.from(qMap['options'] as List),
        );
      }).toList();

      return Questionnaire(
        id: item['id'] as String,
        title: item['title'] as String,
        description: item['description'] as String,
        questions: questions,
      );
    }).toList();
  } else {
    throw Exception('Failed to load questionnaires: ${response.statusCode}');
  }
}
}