import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _yearController = TextEditingController();

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                showSnackBar(context, "Logged out");
                Navigator.pop(context);
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () {
              showSnackBar(context, "Edit Profile Clicked");
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Ayesha"),
              accountEmail: Text("Ayesha@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/user.png"),
              ),
              decoration: BoxDecoration(color: Colors.teal),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => showSnackBar(context, "Home Clicked"),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () => showSnackBar(context, "Settings Clicked"),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Ayesha",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "Flutter Developer",
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),

            // Email Card
            const Card(
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text("Ayesha@gmail.com"),
              ),
            ),

            // Phone Card
            const Card(
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text("01766295555"),
              ),
            ),

            // 🧮 Age Calculator Card
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter your birth year:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _yearController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "e.g. 2000",
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        final input = _yearController.text;
                        int? birthYear = int.tryParse(input);
                        int currentYear = DateTime.now().year;

                        if (birthYear != null &&
                            birthYear <= currentYear &&
                            birthYear > 1900) {
                          int age = currentYear - birthYear;
                          showSnackBar(context, "You are $age years old.");
                        } else {
                          showSnackBar(context, "Please enter a valid year.");
                        }
                      },
                      child: const Text("Calculate Age"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Logout Button
            ElevatedButton(
              onPressed: () => showAlertDialog(context),
              child: const Text("Log Out"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}