import 'package:flutter/material.dart';
import 'package:listacontatos/pages/home_page.dart';

void main() {
  runApp(const ListadeContatosApp());
}

class ListadeContatosApp extends StatelessWidget {
  const ListadeContatosApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Contatos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Lista de Contatos'),
    );
  }
}
