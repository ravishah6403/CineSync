import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:movies_lister_app/api/api.dart';
import 'package:movies_lister_app/api/movie_model.dart';
import 'package:movies_lister_app/widgets/search_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<Movie>> searchResults;

  @override
  void initState() {
    super.initState();
    searchResults = API().searchMovies('');
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) {
                setState(() {
                  searchResults = API().searchMovies(_searchController.text);
                });
              },
              keyboardType: TextInputType.text,
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.grey.shade900,
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          searchResults =
                              API().searchMovies(_searchController.text);
                        });
                      },
                      icon: const Icon(
                        Symbols.search_rounded,
                        color: Colors.black,
                      )),
                  suffixIcon: IconButton(
                      onPressed: () {
                        _searchController.clear();
                      },
                      icon: const Icon(
                        Symbols.clear_rounded,
                        color: Colors.black,
                      )),
                  hintText: 'Enter a Movie name',
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                  fillColor: Colors.white,
                  filled: true),
            ),
          ),
          SizedBox(
            height: 660,
            child: FutureBuilder(
                future: searchResults,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text(
                        'Search results will appear here',
                        style: TextStyle(color: Colors.grey),
                      ));
                    } else {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return SearchItem(movie: snapshot.data![index]);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                          ));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          )
        ],
      ),
    );
  }
}
