import 'package:flutter/material.dart';
import 'package:movies_lister_app/api/api.dart';
import 'package:movies_lister_app/api/movie_model.dart';
import 'package:movies_lister_app/pages/details_page.dart';
import 'package:movies_lister_app/services/database_service.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  List<Movie> watchList = [];
  void getWatchlist() async {
    await DatabaseRepository.instance.getWatchlist().then((value) {
      setState(() {
        watchList = value;
      });
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    getWatchlist();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Watchlist',
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: watchList.isEmpty
            ? const Center(
                child: Text(
                  '''You haven't added any movies to your watchlist''',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: watchList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.58,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () => PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: DetailsPage(movie: watchList[index]),
                            withNavBar: false),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                height: 300,
                                child: watchList[index].posterPath.isEmpty
                                    ? Image.asset(
                                        'assets/imgs/video-movie-placeholder-image-grey_vertical.png',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        '${API.imgPath}${watchList[index].posterPath}',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Text(
                              watchList[index].title,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      );
                    })),
              ));
  }
}
