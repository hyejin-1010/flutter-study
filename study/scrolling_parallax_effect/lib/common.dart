import 'models/location.dart';

const urlPrefix = 'https://flutter.dev/docs/cookbook/img-files/effects/parallax';

class CommonData {
  List<Location> locations = [];

  CommonData() {
    locations = [
      Location(
        name: 'Mount Rushmore',
        place: 'U.S.A',
        imageUrl: '$urlPrefix/01-mount-rushmore.jpg',
      ),
      Location(
        name: 'Singapore',
        place: 'China',
        imageUrl: '$urlPrefix/02-singapore.jpg',
      ),
      Location(
        name: 'Machu Picchu',
        place: 'Peru',
        imageUrl: '$urlPrefix/03-machu-picchu.jpg',
      ),
      Location(
        name: 'Vitznau',
        place: 'Switzerland',
        imageUrl: '$urlPrefix/04-vitznau.jpg',
      ),
      Location(
        name: 'Bali',
        place: 'Indonesia',
        imageUrl: '$urlPrefix/05-bali.jpg',
      ),
      Location(
        name: 'Mexico City',
        place: 'Mexico',
        imageUrl: '$urlPrefix/06-mexico-city.jpg',
      ),
      Location(
        name: 'Cairo',
        place: 'Egypt',
        imageUrl: '$urlPrefix/07-cairo.jpg',
      )
    ];
  }
}
