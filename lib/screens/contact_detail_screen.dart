import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class ContactDetailScreen extends StatefulWidget {
  final Contact contact;

  ContactDetailScreen({required this.contact});

  @override
  _ContactDetailScreenState createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact.name);
    _phoneController = TextEditingController(text: widget.contact.phone);
    _emailController = TextEditingController(text: widget.contact.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes do Contato')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Nome')),
            TextField(controller: _phoneController, decoration: InputDecoration(labelText: 'Telefone'), keyboardType: TextInputType.phone),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'E-mail'), keyboardType: TextInputType.emailAddress),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await DatabaseHelper.instance.update(Contact(
                      id: widget.contact.id,
                      name: _nameController.text,
                      phone: _phoneController.text,
                      email: _emailController.text,
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Contato atualizado com sucesso!')),
                    );
                    Navigator.pop(context, true); // Retorna true para sinalizar que houve uma atualização
                  },
                  child: Text('Atualizar'),
                ),
                  ElevatedButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirmação'),
                          content: Text('Deseja realmente excluir este contato?'),
                          actions: [
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            TextButton(
                              child: Text('Excluir'),
                              onPressed: () async {
                                final result = await DatabaseHelper.instance.delete(widget.contact.id!);
                                if (result > 0) { 
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Contato excluído com sucesso!')),
                                  );
                                  Navigator.of(context).pop(true); // Fecha o diálogo e retorna true
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Erro ao excluir o contato!')),
                                  );
                                  Navigator.of(context).pop(false); // Fecha o diálogo e retorna false se falhar
                                }
                              },
                            ),
                          ],
                        ),
                      ).then((value) {
                        if (value == true) {
                          Navigator.pop(context, true); // Indica para ContactListScreen que houve mudança
                        }
                      });
                    },
                    child: Text('Excluir'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}