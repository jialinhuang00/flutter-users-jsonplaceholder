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
  bool saving = false;
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
    if (respondBody != null) {
      setState(() {
        saving = false;
        isEditing = false;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Update User ${copiedUser.username} Successfully!',
                style: const TextStyle(color: Colors.black)),
            backgroundColor: const Color(0xFFDDDD25),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    return Scaffold(
        appBar: isMobile ? getAppBar() : null,
        body: GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20.0 : 40.0,
              vertical: isMobile ? 20.0 : 40.0,
            ),
            child: getWidget(isMobile),
          ),
        ));
  }

  AppBar getAppBar() {
    return AppBar(
      title: Text(widget.user.name + "'s Profile"),
      backgroundColor: Color(0XFF1a1a1a),
    );
  }

  Widget getWidget(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: !isMobile,
          child: Text("${widget.user.name}'s Profile",
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
              )),
        ),
        const Text('Username',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0XFF18B6FF),
            )),
        !isEditing
            ? Text(widget.user.username,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                ))
            : TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
        const SizedBox(height: 20),
        const Text(
          'Email',
          textAlign: TextAlign.left,
          style: TextStyle(color: Color(0XFFDCDC24)),
        ),
        !isEditing
            ? Text(widget.user.username,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                ))
            : TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(color: Colors.white),
              ),
        const SizedBox(height: 20),
        const Text(
          'Website',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color(0XFFFA44B0),
          ),
        ),
        !isEditing
            ? Text('${widget.user.website}',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                ))
            : TextField(
                controller: websiteController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                enabled: isEditing,
              ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: !saving
                ? () {
                    if (!isEditing) {
                      setState(() {
                        isEditing = true;
                      });
                    } else {
                      setState(() {
                        saving = true;
                      });
                      updateUser();
                    }
                  }
                : () {},
            child: Text(isEditing ? 'Save' : 'Click me to edit'),
          ),
        ),
        Visibility(
          visible: !isMobile,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: const Text(
              'Back to home page',
              style: TextStyle(
                  fontSize: 18.0, decoration: TextDecoration.underline),
            ),
          ),
        )
      ],
    );
  }
}
