import 'package:dio/dio.dart';
import 'package:figma_pogoda2/my_directory_with_pogoda/model/jsonPogodaModel.dart';

#TODO получить объект dio либо через конструктор, либо DI под названием getIt
#TODO нейминг, просто репозиторий
class RepositoryArhitekture {
  final dio = Dio();

  Future<JsonPogodaModel?> fetchPogoda(String location) async {
    #TODO адрес url вынеси в переменную или константу, у этой переменой выдели базовый url
    #key вынеси в константу
    final response = await dio.get<Map<String, dynamic>>(
        'https://api.weatherapi.com/v1/forecast.json?key=a41fe66795314b7bbb0173216241806&q=$location&days=3&aqi=no&alerts=no&lang=ru');
    print(response.statusCode);
    if (response.statusCode == 200 && response.data != null) {
      final result = JsonPogodaModel.fromJson(response.data!);
      return result;
    } else {
      return null;
    }
  }
}
