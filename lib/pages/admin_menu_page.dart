import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/data/menu.dart';
import 'menu_form_page.dart';
import 'package:uuid/uuid.dart'; // untuk generate id unik

class AdminMenuPage extends StatefulWidget {
  @override
  _AdminMenuPageState createState() => _AdminMenuPageState();
}

class _AdminMenuPageState extends State<AdminMenuPage> {
  final List<Menu> _menus = [];

  void _addMenu(Menu menu) {
    setState(() {
      _menus.add(menu);
    });
  }

  void _editMenu(Menu updatedMenu) {
    setState(() {
      final index = _menus.indexWhere((m) => m.id == updatedMenu.id);
      if (index != -1) {
        _menus[index] = updatedMenu;
      }
    });
  }

  void _deleteMenu(String id) {
    setState(() {
      _menus.removeWhere((menu) => menu.id == id);
    });
  }

  void _openForm({Menu? menu}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => MenuFormPage(
              onSave: menu == null ? _addMenu : _editMenu,
              menu: menu,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manajemen Menu')),
      body: ListView.builder(
        itemCount: _menus.length,
        itemBuilder: (context, index) {
          final menu = _menus[index];
          return Card(
            margin: EdgeInsets.all(8),
            elevation: 4,
            child: ListTile(
              leading:
                  menu.imageUrl.isNotEmpty
                      ? Image.network(
                        menu.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                      : Container(width: 50, height: 50, color: Colors.grey),
              title: Text(menu.name),
              subtitle: Text(
                '${menu.description}\nRp ${menu.price.toStringAsFixed(0)}',
              ),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _openForm(menu: menu),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteMenu(menu.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
