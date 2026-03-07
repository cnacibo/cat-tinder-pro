import '../models/cat_image_model.dart';
import '../models/breed_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cat_remote_datasource.dart';

class CatRemoteDataSourceImpl implements CatRemoteDataSource {
  static const _baseUrl = 'https://api.thecatapi.com/v1';
  final String? _apiKey;
  final http.Client _httpClient;

  CatRemoteDataSourceImpl({required http.Client httpClient, String? apiKey})
      : _httpClient = httpClient,
        _apiKey = apiKey;

  @override
  Future<CatImageModel> getRandomCatImage() async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$_baseUrl/images/search?has_breeds=1&limit=1'),
        headers: _apiKey?.isNotEmpty == true ? {'x-api-key': _apiKey!} : {},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return CatImageModel.fromJson(data.first);
        } else {
          throw Exception('No cat images found');
        }
      } else {
        throw Exception(
          'Failed to load cat image: ${response.statusCode}\n'
          'Response: ${response.body}\n'
          'URL: $_baseUrl/images/search?has_breeds=1',
        );
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  @override
  Future<List<BreedModel>> getBreeds() async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$_baseUrl/breeds'),
        headers: _apiKey?.isNotEmpty == true ? {'x-api-key': _apiKey!} : {},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return data.map((json) => BreedModel.fromJson(json)).toList();
        } else {
          throw Exception('Empty data');
        }
      } else {
        throw Exception('Failed to load breeds: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
