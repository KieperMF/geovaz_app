import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geovaz_app/view/home_page.dart';
import 'package:geovaz_app/view/location/controller/data_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

enum LeakType { agua, esgoto }

class LeakDetailsPage extends StatefulWidget {
  LeakDetailsPage({super.key, required this.controller});

  final DataController controller;

  @override
  State<LeakDetailsPage> createState() => _LeakDetailsPageState();
}

class _LeakDetailsPageState extends State<LeakDetailsPage> {
  ValueNotifier<LeakType> leakType = ValueNotifier(LeakType.agua);
  final List<String> intensidades = ["Leve", "Moderada", "Alta"];
  final imagePicker = ImagePicker();
  ValueNotifier<XFile?> userImage = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    Widget _option(String label, LeakType value) {
      final bool isSelected = leakType.value == value;

      return GestureDetector(
        onTap: () {
          setState(() {
            leakType.value = value;
          });
        },
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2),
                color: isSelected ? Colors.blue : Colors.transparent,
              ),
            ),
            const SizedBox(width: 6),
            Text(label),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Detalhes')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tipo de vazamento:', style: TextStyle(fontSize: 16)),
              SizedBox(height: 12),
              ValueListenableBuilder(
                valueListenable: leakType,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      _option("Água", LeakType.agua),
                      const SizedBox(width: 20),
                      _option("Esgoto", LeakType.esgoto),
                    ],
                  );
                },
              ),
              SizedBox(height: 32),
              DropdownButtonFormField<String>(
                items: intensidades.map((item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (value) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  labelText: "Intensidade *",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Selecione a intensidade";
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              Text(
                'Selecione ou tira uma foto do vazamento: ',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      userImage.value = await imagePicker.pickImage(
                        source: ImageSource.camera,
                      );
                      debugPrint("======= ${userImage.value?.path}");
                    },
                    icon: Icon(LucideIcons.camera, size: 44),
                  ),
                  IconButton(
                    onPressed: () async {
                      userImage.value = await imagePicker.pickImage(
                        source: ImageSource.gallery,
                      );
                      debugPrint("======= ${userImage.value?.path}");
                    },
                    icon: Icon(LucideIcons.image, size: 44),
                  ),
                ],
              ),
              ValueListenableBuilder<XFile?>(
                valueListenable: userImage,
                builder: (context, value, _) {
                  if (value == null) {
                    return const SizedBox();
                  }
                  return Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Image.file(File(value.path), fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
        child: InkWell(
          onTap: () async {
            final random = Random();
            final protocol = random.nextInt(999999999);
            await showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text('Solicitação aberta'),
                  content: Text('Protocolo n° ${protocol}.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
              (route) => false,
            );
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Confirmar solicitação',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
