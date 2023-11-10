import 'package:flutter/material.dart';//1
import 'package:pmsn2023/database/agendaDB.dart';//2
import 'package:pmsn2023/models/popular_model.dart';//7
import 'package:pmsn2023/provider/test_provider.dart';//4
import 'package:pmsn2023/network/api_popular.dart';//3
import 'package:pmsn2023/screens/detail_movie_screen.dart';
import 'package:pmsn2023/widgets/MovieWidget.dart';
import 'package:provider/provider.dart';//8


class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  Agenda? agendaDB;
  ApiPopular? apiPopular;
  int favoriteCount = 0;


  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    agendaDB = Agenda();
  }

  @override
  Widget build(BuildContext context) {
  TestProvider flag = Provider.of<TestProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Peliculas Populares"),),
      body: Hero(
        tag: 'imagenpeli',
        child: FutureBuilder(
          future: flag.getupdatePosts() == true
              ? favoriteCount == 0
                  ? agendaDB!.GETALLPOPULAR()
                  : apiPopular!.getAllPopular()
              : favoriteCount == 1
                  ? agendaDB!.GETALLPOPULAR()
                  : apiPopular!.getAllPopular(),
          builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
            if (snapshot.data != null) {
              if (snapshot.data!.isNotEmpty) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    childAspectRatio: .8,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    PopularModel model = snapshot.data![index];
                    if (snapshot.hasData) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DetailMovieScreen(model: model)));
                        },
                        child:
                            ItemPopularMovie(popularModel: snapshot.data![index]),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Algo salio mal :('),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                  itemCount: snapshot.data != null
                      ? snapshot.data!.length
                      : 0, //snapshot.data!.length,
                );
              } else {
                return const Center(
                  child: Text(
                    'Esta muy vacio por aqui :|',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                );
              }
            }
            return Container();
        
          /*future: flag.getupdatePosts()
            ? favoriteCount == 0
              ? agendaDB!.GETALLPOPULAR() 
              : apiPopular!.getAllPopular()
            : favoriteCount == 1
              ? agendaDB!.GETALLPOPULAR
              : apiPopular!.getAllPopular(),
          builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot){
            if(snapshot.hasData){
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, 
                crossAxisSpacing: 10, 
                mainAxisSpacing: 10, 
                childAspectRatio: .9
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  return DetailMovieScreen(snapshot.data![index], context);
                }
              );
            }else{
              if(snapshot.hasError){
                return Center(child: Text("Error al cargar los datos"),);
              
            }else{
                return Center(child: CircularProgressIndicator(),);
              }
            }
          }*/
          }
        ),
      )
    );
  }  
}

/*import 'package:flutter/material.dart';
import 'package:pmsn2023/models/popular_model.dart';
import 'package:pmsn2023/network/api_popular.dart';
import 'package:pmsn2023/widgets/MovieWidget.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? api;
  @override
  void initState() {
    api = ApiPopular();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
      ),
      body: FutureBuilder(
          future: api!.getAllPopular(),
          builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.9),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return MovieWidget(snapshot.data![index], context);
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Algo salio mal :C'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

*/
