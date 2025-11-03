import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geovaz_app/home_page.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController mapController = MapController();
  Location location = Location();
  PermissionStatus? permissionStatus;
  LocationData? locationData;
  bool serviceEnabled = false;
  final ValueNotifier<LatLng?> currentPosition = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    initLocation();
  }

  initLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    if (permissionStatus != PermissionStatus.granted) return;
    locationData = await location.getLocation();
    final LatLng position = LatLng(
      locationData?.latitude ?? 0,
      locationData?.longitude ?? 0,
    );
    currentPosition.value = position;

    mapController.move(position, 16);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeoVaz'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(LucideIcons.chevronLeft),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: currentPosition,
              builder: (context, position, child) {
                debugPrint(
                  'latitude: ${position?.latitude}, longitude: ${position?.longitude}',
                );
                return FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialZoom: 5,
                    initialCenter: position ?? LatLng(0, 0),

                    onTap: (tapPosition, point) {
                      currentPosition.value = point;
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.geovaz.app',
                    ),
                    if (position != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: position,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: currentPosition,
              builder: (context, position, child) {
                if (position != null) {
                  return Align(
                    alignment: AlignmentGeometry.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Text(
                              'Confirmar local',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
