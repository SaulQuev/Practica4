import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pmsn2023/models/actor_model.dart';
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

  Future<String> getVideo(int id) async {
    final URL =
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=f675cdf338b489b41571413d3bdc4f91';
    final response = await http.get(Uri.parse(URL));
    var listVideo = jsonDecode(response.body)['results'] as List;
    if (response.statusCode == 200) {
      listVideo = jsonDecode(response.body)['results'] as List;
    }
    for (var element in listVideo) {
      if (element['type'] == 'Trailer') {
        return element['key'];
      }
    }
    return '';
  }

  Future<List<ActorModel>?> getAllActors(PopularModel popularModel) async {
    final URL = 'https://api.themoviedb.org/3/movie/${popularModel.id}/credits?api_key=f675cdf338b489b41571413d3bdc4f91';
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      var listActor = jsonDecode(response.body)['cast'] as List;
      return listActor.map((actor) => ActorModel.fromMap(actor)).toList();
    }
    return null;
  }
}
