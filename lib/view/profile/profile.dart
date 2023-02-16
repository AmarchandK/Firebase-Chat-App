import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.name, required this.email});
  final String name;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity - 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_4, size: 150),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [const Text("Full Name"), Text(name)],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [const Text("Email"), Text(email)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
