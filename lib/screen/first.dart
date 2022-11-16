import 'package:flutter/material.dart';

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text("Appbar"),),
      body: Container( 
        height: 100,
        width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/10.jpeg")),
            color: Colors.red
          ),
      ),
    );
  }
}
