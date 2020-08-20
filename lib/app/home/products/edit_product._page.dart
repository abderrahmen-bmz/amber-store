import 'package:amber_store/app/home/models/product.dart';
import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditProductPage(),
      ),
    );
  }

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  String _title;
  String _description;
  double _price;
  String _imageUrl;

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // validate and save and submit to firestore
  void _submit() {
    if (_validateAndSaveForm()) {
      Product(
        name: _title,
        description: _description,
        price: _price,
        imageUrl: _imageUrl,
      );
      print('object');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        title: Text("Add product"),
        actions: <Widget>[
          FlatButton(
            onPressed: _submit,
            child: Text(
              'data',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Title'),
        onSaved: (value) => _title = value,
        textInputAction: TextInputAction.next,
        validator: (value) => value.isEmpty ? null : 'Please provide a value.',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Price'),
        textInputAction: TextInputAction.next,
        validator: (value) {
          //   value.isEmpty ? null : 'Please entre a price.';
          //  double.tryParse(value) == null ? null : '';
          if (value.isEmpty) {
            return 'Please entre a price.';
          }
          if (double.tryParse(value) == null) {
            return 'Please entre a valid number.';
          }
          if (double.parse(value) <= 0) {
            return 'Please entre a  number greater than zero.';
          }
          return null;
        },
        onSaved: (value) => _price = int.tryParse(value) ?? 0,
        keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Description'),
        maxLines: 3,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please entre a description';
          }
          if (value.length < 10) {
            return 'Please entre a description';
          }
          return null;
        },
        onSaved: (value) => _description = value,
      ),
      Row(
        children: [
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(
              top: 8,
              right: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: Text('Entre a URL'),
          ),
          Expanded(
            child: TextFormField(
                decoration: InputDecoration(labelText: 'Image URL'),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter an image URL.';
                  }
                  if (!value.startsWith('http') && !value.startsWith('https')) {
                    return 'Please enter a valid URL.';
                  }
                  if (!value.endsWith('.png') &&
                      !value.endsWith('.jpg') &&
                      !value.endsWith('.jpeg')) {
                    return 'Please enter a valid image URL.';
                  }
                  return null;
                },
                onSaved: (value) => _imageUrl = value),
          ),
        ],
      )
    ];
  }
}
