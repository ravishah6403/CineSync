import 'package:flutter/material.dart';
import 'package:movies_lister_app/api/api.dart';
import 'package:movies_lister_app/api/movie_model.dart';
import 'package:movies_lister_app/services/database_service.dart';
import 'package:movies_lister_app/widgets/carousel_slider.dart';
import 'package:movies_lister_app/widgets/list_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> nowPlayingMovies;
  late Future<List<Movie>> topRatedMovies;

  void initDb() async {
    await DatabaseRepository.instance.database;
  }

  @override
  void initState() {
    initDb();
    super.initState();
    trendingMovies = API().getTrendingMovies();
    nowPlayingMovies = API().getNowPlayingMovies();
    topRatedMovies = API().getTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Movies',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Trending',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
              height: 300,
              child: FutureBuilder(
                future: trendingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                            'Unable to load, make sure you are connected to Internet'));
                  } else if (snapshot.hasData) {
                    return TrendingSlider(snapshot: snapshot);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Top Rated',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
            height: 220,
            child: FutureBuilder(
              future: topRatedMovies,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                      child: Text(
                          'Unable to load, make sure you are connected to Internet'));
                } else if (snapshot.hasData) {
                  return ListSlider(snapshot: snapshot);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Now Playing',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
            height: 220,
            child: FutureBuilder(
              future: nowPlayingMovies,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                      child: Text(
                          'Unable to load, make sure you are connected to Internet'));
                } else if (snapshot.hasData) {
                  return ListSlider(snapshot: snapshot);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}
