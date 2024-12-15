import 'package:flutter/material.dart';
import '../screens/contact_list_screen.dart';
import '../screens/add_contact_screen.dart';

void main() {
  runApp(MyApp()); // Certifique-se de que MyApp esteja definido corretamente
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactListScreen(),
      // Rotas nomeadas para navegação
      routes: {
        '/add': (context) => AddContactScreen(),
      }
    );
  }
}
