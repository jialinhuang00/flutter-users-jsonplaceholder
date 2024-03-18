import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:users/app/data/models/user.dart';
import 'package:users/app/data/service/userService.dart';
import 'package:users/pages/UserPage.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  List<User> users = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final userService = UserService();
    var data = await userService.getAllUsers();
    if (data.isNotEmpty) {
      setState(() {
        users = data;
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: getAppBar(),
        // floatingActionButton: getFAB(context),
        body: GestureDetector(
          // onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: getWidget(),
          ),
        ));
  }

  Widget getWidget() {
    if (users.isEmpty || !isLoaded) {
      return const Center(child: CircularProgressIndicator());
    } else if (users.isEmpty) {
      return const Center(
        child: Text('No Users'),
      );
    } else {
      return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPage(user: users[index])),
              );
            },
            child: Card(
              child: ListTile(
                title: Text(users[index].name,style: const TextStyle(),),
                subtitle: Text(users[index].username),
              ),
            ),
          );
        },
      );
    }
  }
}
