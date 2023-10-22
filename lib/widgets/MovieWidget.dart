import 'package:flutter/material.dart';
import 'package:pmsn2023/models/popular_model.dart';

class ItemPopularMovie extends StatelessWidget {
  ItemPopularMovie({super.key, required this.popularModel});

  final PopularModel popularModel;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      fit: BoxFit.cover,
      placeholder: const AssetImage('assets/images/loading.gif'),
      image: NetworkImage(
          'https://image.tmdb.org/t/p/w500/${popularModel.posterPath}'),
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:pmsn2023/models/popular_model.dart';

Widget movieWidget(PopularModel movie, BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, '/detail', arguments: movie),
    child: FadeInImage(
      fit: BoxFit.fill,
      fadeInDuration: const Duration(milliseconds: 500),
      placeholder: const AssetImage('assets/images/loading.gif'),
      image:
          NetworkImage('https://image.tmdb.org/t/p/w500/${movie.posterPath}'),
    ),
  );
}
*/