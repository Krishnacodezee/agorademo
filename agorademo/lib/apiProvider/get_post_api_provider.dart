import 'package:flutter/material.dart';
import 'package:untitled/api/get_post_api.dart';
import 'package:untitled/modal/get_post_api_data.dart';

class GetPostApiDataProvider with ChangeNotifier {
  // List getPostApiData = GetPostApiData() as List;
  List<GetPostApiData> getPostApiData = [];

  bool loading = true;

  getApiData(context) async {
    getPostApiData = await getApiController(context);
    print(getPostApiData);
    loading = false;
    notifyListeners();
  }
}
