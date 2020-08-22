import 'package:amber_store/app/home/models/product.dart';
import 'package:amber_store/common_widgets/platform_alert_dialog.dart';
import 'package:amber_store/common_widgets/platform_exception_alert_dialog.dart';
import 'package:amber_store/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditProductPage extends StatefulWidget {
  EditProductPage({@required this.product});
  final Product product;
  static Future<void> show(BuildContext context, {Product product}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditProductPage(
          product: product,
        ),
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

  String _name;
  String _description;
  double _price;
  String _imageUrl;

  @override
  initState() {
    super.initState();
    if (widget.product != null) {
      _name = widget.product.name;
      _description = widget.product.description;
      _price = widget.product.price;
      _imageUrl = widget.product.imageUrl;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // validate and save and submit to firestore
  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final database = Provider.of<Database>(context, listen: false);
        final products = await database.productsStream().first;
        final allNames = products.map((product) => product.name).toList();
        if (widget.product != null) {
          allNames.remove(widget.product.name);
        }
        if (allNames.contains(_name)) {
          PlatformAlertDialog(
            title: 'Name already used',
            content: 'Please choose a different product name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final id = widget.product?.id ?? documentIdFromCurrentDate();
          final product = Product(
            id: id,
            name: _name,
            description: _description,
            price: _price,
            imageUrl: _imageUrl,
          );
          await database.setProduct(product);
          Navigator.of(context).pop();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  void dispose() {
    //  _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        title: Text(
          widget.product == null ? "New product" : "Edit product",
          style: TextStyle(color: Colors.white),
        ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _submit,
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
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
        initialValue: _name,
        decoration: InputDecoration(labelText: 'Name'),
        onSaved: (value) => _name = value,
        // textInputAction: TextInputAction.next,
        //  onFieldSubmitted: (_) {
        //           FocusScope.of(context).requestFocus(_priceFocusNode);
        //         },
        validator: (value) => value.isEmpty ? 'Please provide a value.' : null,
      ),
      TextFormField(
        initialValue: _price != null ? '$_price' : null,
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
        onSaved: (value) => _price = double.tryParse(value) ?? 0,
        keyboardType: TextInputType.numberWithOptions(),
      ),
      TextFormField(
        initialValue: _description,
        decoration: InputDecoration(labelText: 'Description'),
        maxLines: 3,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please entre a description';
          }
          if (value.length < 5) {
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
                initialValue: _imageUrl,
                decoration: InputDecoration(labelText: 'Image URL'),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return 'Please enter an image URL.';
                //   }
                //   if (!value.startsWith('http') && !value.startsWith('https')) {
                //     return 'Please enter a valid URL.';
                //   }
                //   if (!value.endsWith('.png') &&
                //       !value.endsWith('.jpg') &&
                //       !value.endsWith('.jpeg')) {
                //     return 'Please enter a valid image URL.';
                //   }
                //   return null;
                // },
                onSaved: (value) => _imageUrl = value),
          ),
        ],
      )
    ];
  }
}
