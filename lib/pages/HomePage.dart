import 'package:flutter/material.dart';
import 'package:users/app/data/models/user.dart';
import 'package:users/app/data/service/userService.dart';
import 'package:users/pages/UserPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

List<int> colors = [0xFF1beb9e, 0xFFb060f9, 0xFFdada24, 0xFFfe44b3, 0xFF18b6ff];

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
        body: GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
          var datum = users[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserPage(user: users[index])),
              );
            },
            child: Card(
              color: Color(colors[index % colors.length]),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${datum.name}'),
                    const SizedBox(height: 8),
                    Text('Username: ${datum.username}'),
                    const SizedBox(height: 8),
                    Text('Email: ${datum.email}'),
                    const SizedBox(height: 8),
                    const Text('Address:'),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Street:${datum.address.street}'),
                          Text('Suite: ${datum.address.suite}'),
                          Text('City: ${datum.address.city}'),
                          Text('Zipcode: ${datum.address.zipcode}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Phone:${datum.phone}'),
                    const SizedBox(height: 8),
                    Text('Website: ${datum.website}'),
                    const SizedBox(height: 8),
                    Text('Company:${datum.company}'),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: ${datum.company.name}'),
                          Text('Catch Phrase:${datum.company.catchPhrase}'),
                          Text('Business:${datum.company.bs}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
