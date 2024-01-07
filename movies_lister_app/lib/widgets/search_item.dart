import 'package:flutter/material.dart';
import 'package:movies_lister_app/api/api.dart';
import 'package:movies_lister_app/api/movie_model.dart';
import 'package:movies_lister_app/pages/details_page.dart';
import 'package:movies_lister_app/services/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
          screen: DetailsPage(movie: movie), withNavBar: false),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: movie.posterPath.isEmpty
                  ? Image.asset(
                      'assets/imgs/video-movie-placeholder-image-grey_vertical.png')
                  : Image.network('${API.imgPath}${movie.posterPath}'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    movie.releaseDate.isEmpty
                        ? 'TBA \u2981 ${Constants.languages[movie.language]}'
                        : '${movie.releaseDate.substring(0, 4)} \u2981 ${Constants.languages[movie.language]}',
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
