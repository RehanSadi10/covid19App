import 'package:covid19_app/bloc/covid_events.dart';
import 'package:covid19_app/repository/Covid_model.dart';
import 'package:covid19_app/repository/get_covid_daat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'covid_states.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  CovidBloc() : super(InitialState()) {
    on<CovidEvent>((event, emit) async {
      if (event is FetchDataEvent) {
        emit(CovidIsLoading());

        try {
          CovidModel covidModel = await GetCovidData().getDataAll();
          emit(CovidIsLoaded(covidModel: covidModel));
        } catch (e) {
          emit(CovidIsNotLoaded(error: e.toString()));
        }
      } else if (event is FetchCountries) {
        emit(CountryIsLoading());

        try {
          List<dynamic> list = await GetCovidData().getDataCountries();
          emit(CountryIsLoaded(list: list));
        } catch (e) {
          emit(CovidIsNotLoaded(error: e.toString()));
        }
      }
    });
  }
}
