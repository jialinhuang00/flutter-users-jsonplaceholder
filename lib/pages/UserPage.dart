import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:users/app/data/models/user.dart';
import 'package:users/app/data/service/userService.dart';

class UserPage extends StatefulWidget {
  final User user;

  const UserPage({super.key, required this.user});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isSaveSuccess = false;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    initFields();
  }

  initFields() {
    nameController.text = widget.user.username;
    emailController.text = widget.user.email;
    websiteController.text = widget.user.website;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  Future<void> updateUser() async {
    final userService = UserService();
    var copiedUser = widget.user;
    copiedUser.name = nameController.text;
    copiedUser.email = emailController.text;
    copiedUser.website = websiteController.text;
    var respondBody = await userService.updateUser(copiedUser);
    print(respondBody);
    if (respondBody != null) {
      setState(() {
        isSaveSuccess = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Update User ${copiedUser.username} Successfully!',
                style: TextStyle(color: Colors.black)),
            backgroundColor: Color(0xFFDDDD25),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Update User ${copiedUser.username} FAILED!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(),
        // floatingActionButton: getFAB(context),
        body: GestureDetector(
          // onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: getWidget(),
          ),
        ));
  }

  AppBar getAppBar() {
    return AppBar(
      title: Text(widget.user.name + "'s Profile"),
      backgroundColor: Color(0XFF1a1a1a),
    );
  }

  Widget getWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Username',
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Color(0XFF18B6FF),
            )),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.grey),
          ),
          style: TextStyle(
            color: Colors.white,
          ),
          enabled: isEditing,
        ),
        SizedBox(height: 20),
        Text(
          'Email',
          textAlign: TextAlign.left,
          style: const TextStyle(color: Color(0XFFDCDC24)),
        ),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.grey), // 指定占位符文本的颜色为灰色
          ),
          style: TextStyle(color: Colors.white),
          enabled: isEditing,

        ),
        SizedBox(height: 20),
        Text(
          'Website',
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Color(0XFFFA44B0),
          ),
        ),
        TextField(
          controller: websiteController,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          enabled: isEditing,
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              if (!isEditing) {
                setState(() {
                  isEditing = true;
                });
              } else {
                updateUser();
              }
            },
            child: Text(isEditing ? 'Save' : 'Click me to edit'),
          ),
        ),
      ],
    );
  }
}
