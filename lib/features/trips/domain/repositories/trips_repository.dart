import '../entities/trip_entity.dart';

abstract class TripsRepository {
  List<TripEntity> getAllTrips();
  TripEntity getTripById(String id);
  List<TripEntity> getFavouriteTrips();
  List<TripEntity> getMyTrips();
  bool isFavourite(String tripId);
  bool isBooked(String tripId);
  void toggleFavourite(String tripId);
  void bookTrip(String tripId);
}
