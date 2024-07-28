enum Movie {
  interstellar(
    assetPath: "assets/covers/1.jpg",
    bgImageUrl: "https://ojsfile.ohmynews.com/STD_IMG_FILE/2014/1126/IE001777022_STD.jpg",
    title: "Interstellar",
    description:
        "Interstellar is a science fiction film by Christopher Nolan about astronauts traveling through a wormhole to find a new habitable planet for humanity's survival.",
  ),
  caribbean(
    assetPath: "assets/covers/2.jpg",
    bgImageUrl:
        "https://i.namu.wiki/i/3Dwv-UUrqxDoVTFRm3EuqOSl2B9po1Pweu6wjI7RsGxAUO7IBylNkruMH0KVT_UobnVkGzpBEFmnL_GXat-axw.webp",
    title: "Caribbean",
    description:
        "Pirates of the Caribbean is a popular film series that follows the adventures of the eccentric pirate Captain Jack Sparrow as he navigates treacherous waters and encounters supernatural phenomena",
  ),
  bladeRunner(
    assetPath: "assets/covers/3.jpg",
    bgImageUrl:
        "https://extmovie.com/files/attach/images/135/880/402/024/27d80c5dcb24ae547d966b7e85e341c8.jpg",
    title: "BladeRunner",
    description:
        "Blade Runner is a dystopian science fiction film directed by Ridley Scott, set in a future where a specialized police officer, known as a Blade Runner, hunts down bioengineered beings called replicants.",
  ),
  dune(
      assetPath: "assets/covers/4.jpg",
      bgImageUrl: "https://joyposter.cafe24.com//NEW-posters/F600X848Poster/FMX-974.jpg",
      title: "Dune",
      description:
          "Dune is a science fiction epic directed by Denis Villeneuve, set in a distant future where noble families vie for control of the desert planet Arrakis, the only source of the universe's most valuable substance, spice"),
  darkKnight(
    assetPath: "assets/covers/5.jpg",
    bgImageUrl: "https://joyposter.cafe24.com/MoF/step/FHE427/FHE-039.jpg",
    title: "DartKnight",
    description:
        "The Dark Knight is a superhero film directed by Christopher Nolan, featuring Batman as he battles the chaotic Joker to save Gotham City from destruction.",
  );

  final String assetPath, bgImageUrl, title, description;

  const Movie({
    required this.assetPath,
    required this.bgImageUrl,
    required this.title,
    required this.description,
  });
}

extension MovieExtension on Movie {
  String get longScript {
    return "$description\n\n$description\n\n$description\n\n$description\n\n$description\n\n$description";
  }
}
