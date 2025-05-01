import 'dart:async';
import 'package:career_canvas/core/network/api_client.dart';
import 'package:career_canvas/core/utils/TokenInfo.dart';
import 'package:career_canvas/features/personalitytest/data/models/personalityTestModel.dart';
import 'package:dio/dio.dart';

import '../repositories/PersonalityTestRepository.dart';

class PersonalityTestRepositoryImpl implements PersonalityTestRepository {
  final Dio _dio;

  PersonalityTestRepositoryImpl(this._dio);

  @override
  Future<PersonalityTest?> fetchPersonalityTest(String token) async {
    try {
      final response = await _dio.get(
        '${ApiClient.personalityBase}/questions',
        options:
            Options(headers: {'Authorization': 'Bearer ${TokenInfo.token}'}),
      );
      if (response.statusCode == 200) {
        return PersonalityTest.fromJson(response.data);
      } else {
        throw Exception('Failed to load personality test');
      }
    } catch (e) {
      // print('Error fetching personality test: $e');
      return null;
    }
  }
}
