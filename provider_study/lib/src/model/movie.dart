class Movie {
  String title;
  String posterPath;
  String overview;

  Movie({ this.title, this.overview, this.posterPath });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json["title"] as String,
      overview: json["overview"] as String,
      posterPath: json["poster_path"] as String
    );
  }

  String get posterUrl => "https://image.tmdb.org/t/p/w500/${this.posterPath}";
}