import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" bloc "),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: BlocBuilder()
      bottomNavigationBar: Material(
        color: Colors.transparent, // Background color of the button
        child: MaterialButton(
          onPressed: () {
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Icon(Icons.add,color: Colors.white,),
          color: Colors.orange,
        ),
      ),
    );
  }
}
