import 'dart:convert';

import 'package:http/http.dart' as http;
import 'Covid_model.dart';
import 'api_url.dart';

class GetCovidData {
  Future<CovidModel> getDataAll() async {
    final response = await http.get(Uri.parse(ApiUrl().worldStateApi));

    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);
      return CovidModel.fromJson(temp);
    } else {
      throw Exception('Something Went Wrong');
    }
  }

  Future<List<dynamic>> getDataCountries() async {
    var data;
    final response = await http.get(Uri.parse(ApiUrl().countryStateApi));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Something Went Wrong');
    }
  }
}
