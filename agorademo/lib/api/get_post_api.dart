import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/modal/get_post_api_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer'; //(auto import will do this even)

Future<List<GetPostApiData>> getApiController(BuildContext context) async {
  var url = Uri.parse('https://gorest.co.in/public/v2/users');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<GetPostApiData> myModels = <GetPostApiData>[];
//todo: api data saved with list in pref and fech and print
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      String userData = jsonEncode(response.body.toString());
      prefs.setString('storedData', userData);
      print('-----set-------> $userData');
      String getJson = await prefs.getString('storedData')!;
      log('----get--------> ${jsonDecode(getJson)[0]}');
      List newdata = jsonDecode(jsonDecode(getJson));
      print(newdata[0].toString());
      for (int i = 0; i < newdata.length; i++) {
        myModels.add(GetPostApiData.fromJson(newdata[i]));
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print(e.toString());
    print('No data found');
  }

  return myModels;
}

Future<List<GetPostApiData>> postApiController(context, int id, String name,
    String email, String gender, String status) async {
  var url = Uri.parse('https://gorest.co.in/public/v2/users');
  var token =
      '42086b13f47a96ae874b930b764002dfa1a8b86da2c42fd4ba9602fc2c5b2133';
  List<GetPostApiData> myModels = <GetPostApiData>[];

  try {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'name': name,
        'email': email,
        'gender': gender,
        'status': status,
      }),
    );

    if (response.statusCode == 200) {
      myModels = myModels = (json.decode(response.body) as List<dynamic>)
          .map((i) => GetPostApiData.fromJson(i))
          .toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print(response.body);
    }
  } catch (e) {
    print(e.toString());
    print('No data found');
  }

  return myModels;
}
