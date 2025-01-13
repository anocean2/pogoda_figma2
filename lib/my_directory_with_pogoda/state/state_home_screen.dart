import 'package:figma_pogoda2/my_directory_with_pogoda/repository/weather.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../model/jsonPogodaModel.dart';

part 'state_home_screen.g.dart';

class WeatherState = WeatherStateBase with _$WeatherState;

abstract class WeatherStateBase with Store {
  #TODO получить объект репозитория либо через конструктор либо через getIt
  final repositoryArhitekture = RepositoryArhitekture();

  @observable
  #TODO заменить var на final
  var currentCity = JsonPogodaModel();

  @observable
  ObservableList<String> listNameCity =
      ObservableList<String>.of(['Москва', 'Дербент']);

  @observable
  ObservableList<JsonPogodaModel> listCurrentCity =
      ObservableList<JsonPogodaModel>();

  @computed
  int get length => listNameCity.length;

  @action
  Future<void> loadPogodaModelList() async {
    for (int i = 0; i <= listNameCity.length; i++) {
      final listResultCurrentCity =
          await repositoryArhitekture.fetchPogoda(listNameCity[i]);
      #TODO ты не можешь использовать бенг оператор если не проверил на null
      listCurrentCity.add(listResultCurrentCity!);
    }
  }

  @action
  Future<void> loadPogodaModel({String? city}) async {

    final result =
        await repositoryArhitekture.fetchPogoda(city ?? listNameCity.first);
    if (result != null) {
      currentCity = result;
    }
  }

  #TODO подкорректировать нейминг
  @action
  Future<void> addCityToObservableList(String city) async {
    listNameCity.add(city);
    final listResultCurrentCity = await repositoryArhitekture.fetchPogoda(city);
    listCurrentCity.add(listResultCurrentCity!);
  }

  #TODO убрать лишний контекст и контексты в стейты желательно
  @action
  Future<void> onCityTap(String city, BuildContext context) async {
    await loadPogodaModel(city: city);
  }

  @action
  Future<void> cityHome(String city, BuildContext context) async {
    await loadPogodaModel(city: city);
  }

  Future<void> onSubmittedAndAddCityToObservableList(
      {required String city, required BuildContext context}) async {
    Navigator.pop(context);
    onCityTap(city, context);
    addCityToObservableList(city);
  }

  void initialization() {
    loadPogodaModel();
    loadPogodaModelList();
  }
}
