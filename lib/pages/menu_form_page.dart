import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/data/menu.dart';
import 'package:uuid/uuid.dart';

class MenuFormPage extends StatefulWidget {
  final Function(Menu) onSave;
  final Menu? menu;

  MenuFormPage({required this.onSave, this.menu});

  @override
  _MenuFormPageState createState() => _MenuFormPageState();
}

class _MenuFormPageState extends State<MenuFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late double _price;
  late String _imageUrl;

  @override
  void initState() {
    super.initState();
    _name = widget.menu?.name ?? '';
    _description = widget.menu?.description ?? '';
    _price = widget.menu?.price ?? 0.0;
    _imageUrl = widget.menu?.imageUrl ?? '';
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final menu = Menu(
        id: widget.menu?.id ?? Uuid().v4(),
        name: _name,
        description: _description,
        price: _price,
        imageUrl: _imageUrl,
      );
      widget.onSave(menu);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.menu == null ? 'Tambah Menu' : 'Edit Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Nama Menu'),
                validator: (value) => value!.isEmpty ? 'Masukkan nama' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                validator:
                    (value) => value!.isEmpty ? 'Masukkan deskripsi' : null,
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                initialValue: _price == 0.0 ? '' : _price.toString(),
                decoration: InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Masukkan harga' : null,
                onSaved: (value) => _price = double.parse(value!),
              ),
              TextFormField(
                initialValue: _imageUrl,
                decoration: InputDecoration(labelText: 'URL Gambar (opsional)'),
                onSaved: (value) => _imageUrl = value ?? '',
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}
