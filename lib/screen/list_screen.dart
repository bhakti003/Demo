import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../getcontroller/phonecontroller.dart';
import '../user_model.dart';
import 'add_screen.dart';
import 'edit_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final homePageController = Get.put(HomePageController());

  @override
  void initState() {
   homePageController.createDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contect'),backgroundColor: Color(0xfff25220),
      actions: [GestureDetector(
          onTap: (){
            Get.to(AddScreen());
          },
          child: Icon(Icons.add,color: Colors.white,size: 25,))],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [

             Obx(() =>  Container(
               height: 1000,
               child: ListView.separated(
                 itemCount: homePageController.userData.length,
                 shrinkWrap: true,
                 itemBuilder: (context,index)  {

                   return Dismissible(background: Container(color: Color(0xfff25220),child: Icon(Icons.delete),
                   ),
                     key: ValueKey(index),
                     onDismissed: (DismissDirection direction) {
                     setState(() {
                       homePageController.deleteDatabase(id: homePageController.userData[index].id);
                     });

                     },
                     child: Card(
                       borderOnForeground: true,
                       shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                       color: Colors.grey.withOpacity(0.6),
                       child:ListTile(
                         onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(

                              mphones: homePageController.userData[index]),

                          ));
                         },
                         title: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(homePageController.userData[index].name.toString(),style: TextStyle(color: Colors.black),),
                             Text(homePageController.userData[index].phone!,style: TextStyle(color: Colors.black),),
                             Text(homePageController.userData[index].email!,style: TextStyle(color: Colors.black),),
                           ],
                         ),
                         leading: CircleAvatar(
                           radius: 50,
                           backgroundImage: FileImage(File(homePageController.userData[index].image.toString())),
                         ),

                       ) ,
                     ),
                   );
                 }, separatorBuilder: (context,index){return SizedBox(height: 10,);}, ),
             ))

            ],
          ),
        ),
      ),
    );
  }
}







