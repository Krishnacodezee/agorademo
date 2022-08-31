import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/modal/coumtry_api_data.dart';

Future<CountryApiData> countryApiController(context) async {
  var url = Uri.parse('https://api.nationalize.io/?name=nathaniel');

  CountryApiData? myModels;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    var response = await http.get(url);
//todo: api data saved with json only in pref and fech and print

    if (response.statusCode == 200) {
      String userData = jsonEncode(response.body.toString());
      prefs.setString('storedData', userData);
      print('-----set-------> $userData');
      String getJson = await prefs.getString('storedData')!;
      log('----get--------> ${jsonDecode(getJson)}');
      Map<String, dynamic> map2 = jsonDecode(jsonDecode(getJson));
      myModels = CountryApiData.fromJson(map2);
      // Map<String, dynamic> map1 = jsonDecode(getJson);
      // print("-=----=-=-=-=-=->>>>>>$map1");

      // myModels = CountryApiData.fromJson(json.decode(response.body));
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print(response.body);
    }
  } catch (e) {
    print(e.toString());
    print('No data found');
  }

  return myModels!;
}
