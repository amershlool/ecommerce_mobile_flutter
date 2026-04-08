import 'package:e_commerce/controller/address_controller.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomScreenGps extends StatefulWidget {
  const CustomScreenGps({super.key});

  @override
  State<CustomScreenGps> createState() => _CustomScreenGpsState();
}

class _CustomScreenGpsState extends State<CustomScreenGps> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressControllerImp>(
      builder: (controller) {
        if (controller.lat == 0.0 || controller.long == 0.0) {
          return SizedBox(
            height: 300,

            child: const Center(
              child: CircularProgressIndicator(color: AppColor.hotRed),
            ),
          );
        }

        LatLng currentLang = LatLng(controller.lat, controller.long);

        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(16),
            ),
            child: GoogleMap(
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              rotateGesturesEnabled: true,
              myLocationButtonEnabled: true,
              mapToolbarEnabled: true,
              compassEnabled: true,
              initialCameraPosition: CameraPosition(
                target: currentLang,
                zoom: 15,
              ),
              onTap: (LatLng newPosition) {
                controller.updateLocation(
                  newPosition.latitude,
                  newPosition.longitude,
                );
              },
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position: currentLang,
                  infoWindow: const InfoWindow(title: "موقعي الحالي"),
                ),
              },
              myLocationEnabled: true,
              zoomControlsEnabled: true,
            ),
          ),
        );
      },
    );
  }
}
