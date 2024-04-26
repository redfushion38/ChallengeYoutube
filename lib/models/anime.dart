class Anime {
  final String name;
  final double score;
  final int number;
  final String poster;
  const Anime({required this.name, required this.score, required this.number, required this.poster});
}

const trendsData = [
  Anime(
      name: 'My Hero Academy',
      number: 201,
      score: 8.33,
      poster: 'assets/images/hero-academy.png'),
  Anime(
      name: 'Haikyuu!!',
      number: 22,
      score: 8.83,
      poster: 'assets/images/haikyuu.png'),
  Anime(
      name: 'SAO: Alicization',
      number: 1303,
      score: 7.64,
      poster: 'assets/images/alicization.png'),
];

const recentsData = [
  Anime(
    name: 'Somali to Mori no Kamisama',
    number: 1303,
    score: 7.64,
    poster: 'assets/images/somali.png',
  ),
  Anime(
    name: 'ID-Invaded',
    number: 1303,
    score: 7.64,
    poster: 'assets/images/id.png',
  ),
  Anime(
    name: 'Ride your wave',
    number: 22,
    score: 8.83,
    poster: 'assets/images/ride.png',
  ),
  Anime(
    name: 'Re: Zero',
    number: 201,
    score: 8.33,
    poster: 'assets/images/re-zer.png',
  ),
];
