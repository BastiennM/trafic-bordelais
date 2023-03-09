import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  final RxString homeText = "Home text".obs;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final Rx<Position?> currentPosition = Rx(null);
  final RxBool isLoadingPosition = true.obs;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final Position position = await Geolocator.getCurrentPosition();
    isLoadingPosition.value = false;

    return position;
  }

  @override
  onInit() async{
    super.onInit();
    currentPosition.value = await determinePosition();
    print(currentPosition.value);
  }
}
