import 'package:flutter/material.dart';
import '../screens/contact_detail_screen.dart';
import '../screens/add_contact_screen.dart';
import '../database/database_helper.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Contatos')),
      body: FutureBuilder<List<Contact>>(
        key: ValueKey(DateTime.now()),
        future: DatabaseHelper.instance.getContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar contatos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum contato encontrado'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Contact contact = snapshot.data![index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phone),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactDetailScreen(contact: contact),
                      ),
                    );
                    if (result == true) {
                      setState(() {}); // Atualiza a lista após a exclusão ou edição
                    }
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContactScreen()),
          );
          if (result == true) {
            setState(() {}); // Atualiza a lista quando um novo contato é adicionado
          }
        },
        tooltip: 'Adicionar Contato',
        child: Icon(Icons.add),
      ),
    );
  }
}