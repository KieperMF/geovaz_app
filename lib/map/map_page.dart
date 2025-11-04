import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geovaz_app/home_page.dart';
import 'package:geovaz_app/map/map_data_controller.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final controller = MapDataController();

  @override
  void initState() {
    super.initState();
    controller.initLocation();
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
              valueListenable: controller.currentPosition,
              builder: (context, position, child) {
                debugPrint(
                  'latitude: ${position?.latitude}, longitude: ${position?.longitude}',
                );
                return FlutterMap(
                  mapController: controller.mapController,
                  options: MapOptions(
                    initialZoom: 5,
                    initialCenter: position ?? LatLng(0, 0),

                    onTap: (tapPosition, point) {
                      controller.currentPosition.value = point;
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
            Positioned(
              right: 10,
              bottom: 80,
              child: Column(
                children: [
                  FloatingActionButton.small(
                    heroTag: "zoom_in",
                    child: const Icon(Icons.add),
                    onPressed: () {
                      final zoom = controller.mapController.camera.zoom + 1;
                      controller.mapController.move(
                        controller.mapController.camera.center,
                        zoom,
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton.small(
                    heroTag: "zoom_out",
                    child: const Icon(Icons.remove),
                    onPressed: () {
                      final zoom = controller.mapController.camera.zoom - 1;
                      controller.mapController.move(
                        controller.mapController.camera.center,
                        zoom,
                      );
                    },
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: controller.currentPosition,
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
