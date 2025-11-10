import 'package:flutter/material.dart';
import 'package:geovaz_app/view/location/controller/data_controller.dart';
import 'package:geovaz_app/view/location/pages/leak_details_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ContactDataPage extends StatefulWidget {
  ContactDataPage({super.key, required this.controller});

  final DataController controller;

  @override
  State<ContactDataPage> createState() => _ContactDataPageState();
}

class _ContactDataPageState extends State<ContactDataPage> {
  final emailCtl = TextEditingController();

  final nameCtl = TextEditingController();

  final phoneCtl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final image = ImagePicker();

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                TextFormField(
                  controller: nameCtl,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text('Nome'),
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: emailCtl,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Informe um e-mail';

                    final emailRegex = RegExp(
                      r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(value)) return 'E-mail inválido';

                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text('E-mail'),
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  controller: phoneCtl,
                  validator: (value) {
                    if (value == null || value.length < 9 || value.length > 9) {
                      return 'Numero inválido';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text('Telefone'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
        child: InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              widget.controller.customerName = nameCtl.text;
              widget.controller.customerEmail = emailCtl.text;
              widget.controller.customerPhone = phoneCtl.text;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LeakDetailsPage(controller: widget.controller),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('Preencha os campos obrigatórios'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
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
