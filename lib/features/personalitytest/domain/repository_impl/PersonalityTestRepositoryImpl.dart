import 'dart:async';
import 'package:career_canvas/features/personalitytest/data/models/personalityTestModel.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/PersonalityTestRepository.dart';

class PersonalityTestRepositoryImpl implements PersonalityTestRepository {
  final Dio _dio;
  
  PersonalityTestRepositoryImpl(this._dio);

  @override
  Future<PersonalityTest?> fetchPersonalityTest(String token) async {
    try {
       final prefs = await SharedPreferences.getInstance();
       String token = prefs.getString('token') ?? '';

      final response = await _dio.get(
        'https://personality.api.careercanvas.pro/personality-test/questions',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        return PersonalityTest.fromJson(response.data);
      } else {
        throw Exception('Failed to load personality test');
      }
    } catch (e) {
      print('Error fetching personality test: $e');
      return null;
    }
  }
}
