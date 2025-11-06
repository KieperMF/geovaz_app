import 'package:flutter/material.dart';

class ContactDataPage extends StatelessWidget {
  ContactDataPage({super.key});

  final emailCtl = TextEditingController();
  final nameCtl = TextEditingController();
  final phoneCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Informações para contato')),
      body: SafeArea(child: Column(spacing: 10, children: [
        
      ],)),
    );
  }
}
