import 'package:flutter/foundation.dart';

import '../entities/trip_entity.dart';

/// ChangeNotifier عشان أي شاشة تسمع التغييرات (حجز/مفضلة) اللي بتحصل
/// من أي شاشة تانية وتحدّث نفسها فوراً، من غير ما نحتاج state management
/// تقيل زي Bloc لبيانات مؤقتة محلية كده.
abstract class TripsRepository extends ChangeNotifier {
  List<TripEntity> getAllTrips();
  TripEntity getTripById(String id);
  List<TripEntity> getFavouriteTrips();
  List<TripEntity> getMyTrips();
  bool isFavourite(String tripId);
  bool isBooked(String tripId);
  void toggleFavourite(String tripId);
  void bookTrip(String tripId);
}
