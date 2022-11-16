import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getcontroller/phonecontroller.dart';
import '../model.dart';
import 'add_screen.dart';

class EditScreen extends StatefulWidget {
  Phones? mphones;
  EditScreen({Key? key, this.mphones}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var homePageController = Get.put(HomePageController());
  int SelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10.withOpacity(0.2),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: SelectedIndex,

          backgroundColor: const Color(0xfff25220),
          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          elevation: 5,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              label: '',
              backgroundColor: Color(0xfff25220),
            ),

            BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddScreen(
                              model: widget.mphones!,
                            ),
                          ));
                    },
                    child: const Icon(Icons.edit)),
                label: ''),

            const BottomNavigationBarItem(icon: Icon(Icons.share), label: ''),


            const BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz_rounded), label: ''),
          ],
        onTap: (index) {
          SelectedIndex = index;
        },),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 120, left: 20),
                      height: 480,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black38,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            widget.mphones!.name!,
                            style: const TextStyle(fontSize: 50),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Mobeli',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.mphones!.phone!,
                                style: const TextStyle(fontSize: 30),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 35,
                      left: 100,
                      child: CircleAvatar(
                        backgroundImage:
                            FileImage(File(widget.mphones!.image!)),
                        radius: 100,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
