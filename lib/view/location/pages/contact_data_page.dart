import 'package:flutter/material.dart';
import 'package:geovaz_app/view/location/controller/data_controller.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ContactDataPage extends StatelessWidget {
  ContactDataPage({super.key, required this.controller});

  final DataController controller;
  final emailCtl = TextEditingController();
  final nameCtl = TextEditingController();
  final phoneCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações para contato'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(LucideIcons.chevronLeft),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            spacing: 10,
            children: [
              Text('Cidade: ${controller.address.city}'),
              Text('Rua: ${controller.address.road}'),
              Text('Estado: ${controller.address.state}'),
              if (controller.address.houseNumber.isNotEmpty)
                Text('Numero: ${controller.address.houseNumber}'),
              if (controller.address.zipCode.isNotEmpty)
                Text('Cep: ${controller.address.zipCode}'),
              SizedBox(height: 25),
              TextFormField(
                controller: nameCtl,
                decoration: InputDecoration(
                  label: Text('Nome'),
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: emailCtl,
                decoration: InputDecoration(
                  label: Text('E-mail'),
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: phoneCtl,
                decoration: InputDecoration(
                  label: Text('Telefone'),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text('Continuar', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
