import '../../domain/entities/trip_entity.dart';
import '../../domain/repositories/trips_repository.dart';
import '../datasources/trips_mock_data_source.dart';

class TripsRepositoryImpl extends TripsRepository {
  TripsRepositoryImpl(this._dataSource);

  final TripsMockDataSource _dataSource;

  final Set<String> _favouriteIds = {};
  final Set<String> _bookedIds = {};

  @override
  List<TripEntity> getAllTrips() => _dataSource.getAllTrips();

  @override
  TripEntity getTripById(String id) =>
      _dataSource.getAllTrips().firstWhere((trip) => trip.id == id);

  @override
  List<TripEntity> getFavouriteTrips() => _dataSource
      .getAllTrips()
      .where((trip) => _favouriteIds.contains(trip.id))
      .toList();

  @override
  List<TripEntity> getMyTrips() => _dataSource
      .getAllTrips()
      .where((trip) => _bookedIds.contains(trip.id))
      .toList();

  @override
  bool isFavourite(String tripId) => _favouriteIds.contains(tripId);

  @override
  bool isBooked(String tripId) => _bookedIds.contains(tripId);

  @override
  void toggleFavourite(String tripId) {
    if (_favouriteIds.contains(tripId)) {
      _favouriteIds.remove(tripId);
    } else {
      _favouriteIds.add(tripId);
    }
    notifyListeners();
  }

  @override
  void bookTrip(String tripId) {
    _bookedIds.add(tripId);
    notifyListeners();
  }
}
