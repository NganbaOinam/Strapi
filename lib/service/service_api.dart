import 'dart:convert';

import '../model/data.model.dart';
import 'package:http/http.dart' as http;

class SeviceApi {
  Future<DistrictsModel> fetchData() async {
    final response = await http.get(
        Uri.parse("https://strapi-test-nielit.herokuapp.com/api/districts"));
    if (response.statusCode == 200) {
      return DistrictsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Unexpected error occured!");
    }
  }

  postData(String districtName) async {
    var data = [
      {
        "data": {"name": districtName}
      }
    ];
    final response = await http.post(
        Uri.parse("https://strapi-test-nielit.herokuapp.com/api/districts"),
        body: jsonEncode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      return DistrictsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Unexpected error occured!");
    }
  }
}
