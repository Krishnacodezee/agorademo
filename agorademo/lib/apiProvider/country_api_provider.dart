import 'package:flutter/material.dart';
import 'package:untitled/api/country_api.dart';
import 'package:untitled/modal/coumtry_api_data.dart';

class countryDataProvider with ChangeNotifier {
  CountryApiData CountryData = CountryApiData();
  bool loading = true;

  getCountryData(context) async {
    CountryData = await countryApiController(context);
    print(CountryData);
    loading = false;

    notifyListeners();
  }
}
