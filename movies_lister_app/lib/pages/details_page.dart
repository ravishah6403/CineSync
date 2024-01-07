import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:movies_lister_app/api/api.dart';
import 'package:movies_lister_app/api/movie_model.dart';
import 'package:movies_lister_app/services/constants.dart';
import 'package:movies_lister_app/services/database_service.dart';
import 'package:movies_lister_app/widgets/button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.movie});

  final Movie movie;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isAdded = false;

  void addToWatchlist() async {
    await DatabaseRepository.instance
        .insert(movie: widget.movie)
        .catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
    _isAdded(id: widget.movie.id);
  }

  void delete() async {
    DatabaseRepository.instance.delete(widget.movie.id).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
    _isAdded(id: widget.movie.id);
  }

  void _isAdded({required int id}) async {
    final result = await DatabaseRepository.instance.doesExists(id);
    setState(() {
      isAdded = result;
    });
  }

  @override
  void initState() {
    _isAdded(id: widget.movie.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.movie.title),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 240,
                  child: (widget.movie.backdropPath.isEmpty)
                      ? Image.asset(
                          'assets/imgs/video-movie-placeholder-image-grey.png',
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          '${API.imgPathHQ}${widget.movie.backdropPath}',
                          fit: BoxFit.cover,
                          //loadingBuilder:
                        ),
                ),
              ),
            ),
            Text(
              widget.movie.releaseDate.isEmpty
                  ? 'TBA \u2981 ${Constants.languages[widget.movie.language]}'
                  : '${widget.movie.releaseDate.substring(0, 4)} \u2981 ${Constants.languages[widget.movie.language]}',
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Overview',
                    style: TextStyle(fontSize: 20),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.movie.overview,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                MyButton(
                    icon: Symbols.heart_plus_rounded,
                    selectedIcon: Symbols.done_rounded,
                    isSelected: isAdded,
                    text: isAdded ? 'Added' : 'Watchlist',
                    function: isAdded ? delete : addToWatchlist),
                MyButton(
                    icon: Symbols.share_rounded,
                    selectedIcon: Symbols.share_rounded,
                    isSelected: false,
                    text: 'Share',
                    function: () => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Upcoming'),
                        ))),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBarIndicator(
                      rating: widget.movie.voteAverage / 2,
                      itemCount: 5,
                      itemSize: 30,
                      itemBuilder: (context, index) {
                        return const Icon(
                          Symbols.star_rounded,
                          color: Colors.amber,
                          fill: 1,
                        );
                      }),
                )
              ],
            ),
          ],
        ));
  }
}
