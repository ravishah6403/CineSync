class Movie {
  int id;
  String title;
  String overview;
  String releaseDate;
  String backdropPath;
  String posterPath;
  double voteAverage;
  String language;

  Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.releaseDate,
      required this.backdropPath,
      required this.posterPath,
      required this.voteAverage,
      required this.language});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['title'] ?? 'Title',
        overview: json['overview'] ?? 'Overview',
        releaseDate: json['release_date'] ?? '',
        backdropPath: json['backdrop_path'] ?? '',
        posterPath: json['poster_path'] ?? '',
        voteAverage: json['vote_average'] as double,
        language: json['original_language']);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
      'overview': overview,
      'releaseDate': releaseDate,
      'backdropPath': backdropPath,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'language': language
    };
    return map;
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
        id: map['id'],
        title: map['title'],
        overview: map['overview'],
        releaseDate: map['releaseDate'],
        backdropPath: map['backdropPath'],
        posterPath: map['posterPath'],
        voteAverage: map['voteAverage'],
        language: map['language']);
  }
}
