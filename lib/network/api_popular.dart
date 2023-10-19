import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pmsn2023/models/popular_model.dart';

class ApiPopular {
  Uri link = Uri.parse(
      "https://api.themoviedb.org/3/movie/popular?api_key=f675cdf338b489b41571413d3bdc4f91&language=es-MX&page=1%27)");

  Future<List<PopularModel>?> getAllPopular() async {
    var response = await http.get(link);

    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(response.body)["results"] as List;
      return jsonRes.map((popular) => PopularModel.fromMap(popular)).toList();
    } else {
      return null;
    }
  }
}
