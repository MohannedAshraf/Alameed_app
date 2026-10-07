class TripEntity {
  const TripEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.imagePath,
    required this.duration,
    required this.rating,
    required this.description,
    required this.included,
    required this.notIncluded,
  });

  final String id;
  final String title;
  final String location;
  final String price;
  final String imagePath;
  final String duration;
  final double rating;
  final String description;
  final List<String> included;
  final List<String> notIncluded;
}
