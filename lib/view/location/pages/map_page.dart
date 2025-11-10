import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geovaz_app/view/home_page.dart';
import 'package:geovaz_app/view/location/controller/data_controller.dart';
import 'package:geovaz_app/view/location/pages/contact_data_page.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final controller = DataController();

  @override
  void initState() {
    super.initState();
    controller.initLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecionar local'),
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

                    onTap: (tapPosition, point) async {
                      controller.currentPosition.value = point;
                      await controller.getAddressFromLatLng(point);
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
                            alignment: Alignment(0, -0.5),
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
                  return Positioned(
                    left: 50,
                    right: 50,
                    bottom: 16,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: controller.address,
                            builder: (context, value, child) {
                              if (controller.address.value.city.isNotEmpty)
                                return Container(
                                  width: 220,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withAlpha(180),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsGeometry.all(8),
                                    child: Text(
                                      '${controller.address.value.road}, ${controller.address.value.city}, ${controller.address.value.zipCode}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              return SizedBox();
                            },
                          ),
                          SizedBox(height: 12),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ContactDataPage(controller: controller),
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 220,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
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
                        ],
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
