import 'package:flutter/material.dart';
import 'package:geovaz_app/view/map/controller/data_controller.dart';

class ContactDataPage extends StatelessWidget {
  ContactDataPage({super.key, required this.controller});

  final DataController controller;
  final emailCtl = TextEditingController();
  final nameCtl = TextEditingController();
  final phoneCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Informações para contato')),
      body: SafeArea(
        child: Column(
          spacing: 10,
          children: [Text('rua: ${controller.address.road}')],
        ),
      ),
    );
  }
}
