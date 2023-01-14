class ApiUrl {
  final String baseUrl = "https://disease.sh/v3/covid-19/";
  late final String worldStateApi = "${baseUrl}all";
  late final String countryStateApi = "${baseUrl}countries";
}
