import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.menu,color: Colors.white,),
          onPressed: (){},
        ),
        centerTitle: true,
        title: Text(
          'Amber Store',
          style: TextStyle(color: Colors.white),
        ),
      actions: [
        IconButton(
          icon: Icon(Icons.menu,color: Colors.white,),
          onPressed: (){},
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart,color: Colors.white,),
          onPressed: (){},
        ),
      ],
      ),
      body: Center(
        child: Container(
          child: Text('Home Page ? '),
        ),
      ),
    );
  }
}
