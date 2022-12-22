import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Services/LocationServices/LocationService.dart';

final locationProvider = FutureProvider((ref) {
  return LocationService().getLocation();
});
