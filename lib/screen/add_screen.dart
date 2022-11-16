import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../getcontroller/phonecontroller.dart';
import '../model.dart';

class AddScreen extends StatefulWidget {
  Phones? model;
  AddScreen({Key? key,this.model}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final homePageController  = Get.put(HomePageController());
  final ImagePicker _picker = ImagePicker();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
 final _formkey = GlobalKey<FormState>();
  var imageshow;
  @override
  void initState() {
    super.initState();
    if(widget.model != null) {
      nameController.text = widget.model!.name!;
      phoneController.text = widget.model!.phone!;
      emailController.text = widget.model!.email!;
      imageshow = widget.model!.image!;
    }
  }
  void dispose() {
    super.dispose();
    nameController.clear();
    phoneController.clear();
    emailController.clear();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Contacts"), backgroundColor: Color(0xfff25220), centerTitle: true),
      backgroundColor: Colors.white10.withOpacity(0.2),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
        children: [
          SizedBox(height: 19,),
            Center(
              child: CircleAvatar(
                backgroundColor: Color(0xfff25220),
                radius: 60,
                child: ClipOval(
                  child: imageshow != null
                      ? Image.file(File(imageshow), fit: BoxFit.fill, height: 1000, width: 1000,)
                      : GestureDetector(
                          onTap: () async {
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              imageshow = image!.path;
                              print("imageshow ${imageshow}");
                            });
                          },
                          child: Icon(Icons.camera_alt)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  validator: (name){
                    if(name!.isEmpty){
                      return 'Enter Name';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: phoneController,
             validator: (name){
    if(name!.isEmpty){
    return 'Enter Number';
    }
    },
                decoration: InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: Icon(Icons.call),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
              validator: (name){
    if(name!.isEmpty){
    return 'Enter Email';
    }    },
                decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Groups',
                    prefixIcon: Icon(Icons.call),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: Icon(Icons.group),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Notes',
                    prefixIcon: Icon(Icons.note_alt),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(onTap: (){
                  Get.back();
                },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Color(0xfff25220), fontSize: 25),
                  ),
                ),
                GestureDetector(onTap: (){
                  Get.back();
                 if(_formkey.currentState!.validate()) {

                   if (widget.model != null) {
                     homePageController.updateDatabase(Phones(
                         id: widget.model!.id,
                         name: nameController.text,
                         phone: phoneController.text,
                         email: emailController.text,
                         image: imageshow
                     ));
                   } else {
                     homePageController.addData(name: nameController.text,
                         phone: phoneController.text,
                         email: emailController.text,
                         image: imageshow);
                   }
                 }

                },
                  child: Text(
                    widget.model == null ?'Save' : 'Update',
                    style: TextStyle(color: Color(0xfff25220), fontSize: 25),
                  ),
                )
              ],
            )
        ],
      ),
          )),
    );
  }
}
