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
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  Future<void> updateUser() async {
    final userService = UserService();
    var userData = widget.user;
    var isSuccess = await userService.updateUser(userData);
    if (isSuccess) {
      setState(() {
        isSaveSuccess = true;
      });
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
        Visibility(
          visible: !isEditing,
          child: Column(
            children: [
              Text('Username: ${widget.user.username}',
                  style: const TextStyle(
                    color: Color(0XFF18B6FF),
                  )),
              Text('Email: ${widget.user.email}',
                  style: const TextStyle(color: Color(0XFFDCDC24))),
              Text('Website: ${widget.user.website}',
                  style: const TextStyle(color: Color(0XFFFA44B0))),
            ],
          ),
        ),
        Visibility(
            visible: isEditing,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  enabled: isEditing,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                  enabled: isEditing,
                ),
                TextField(
                  controller: websiteController,
                  decoration: const InputDecoration(
                    labelText: 'Website',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                  enabled: isEditing,
                ),
              ],
            )),
        Center(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
                // 如果正在编辑，则清空文本字段
                if (!isEditing) {
                  nameController.clear();
                  emailController.clear();
                } else {
                  nameController.text = widget.user.username;
                  emailController.text = widget.user.email;
                  websiteController.text = widget.user.website;
                }
              });
            },
            child: Text(isEditing ? 'Save' : 'Edit'),
          ),
        ),
      ],
    );
  }
}
