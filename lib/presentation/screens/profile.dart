import 'package:flutter/material.dart';

class ProfileTwo extends StatefulWidget {
  const ProfileTwo({Key? key}) : super(key: key);

  @override
  State<ProfileTwo> createState() => _ProfileTwoState();
}

class _ProfileTwoState extends State<ProfileTwo> {
  final TextEditingController _name =
      TextEditingController(text: "Meron fantahun");
  final TextEditingController _controller =
      TextEditingController(text: "09919123433");
  final TextEditingController _email =
      TextEditingController(text: "@m_fantahun");

  bool _isNameEnabled = false;
  bool _isPhoneEnabled = false;
  bool _isEmailEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue[300],
          title: const Center(
            child: Text(
              'your Profile',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 100.0,
                    child: Icon(
                      Icons.account_circle,
                      size: 200,
                    ),
                  ),
                  const Divider(
                    height: 60,
                    color: Colors.black,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildProfileField("Name", _name, _isNameEnabled),
                      buildProfileField(
                          "Phone number", _controller, _isPhoneEnabled),
                      buildProfileField("Email", _email, _isEmailEnabled),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildProfileField(
      String label, TextEditingController controller, bool isEnabled) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                letterSpacing: 2.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: controller,
                    enabled: isEnabled,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      if (label == "Name") {
                        _isNameEnabled = !_isNameEnabled;
                      } else if (label == "Phone number") {
                        _isPhoneEnabled = !_isPhoneEnabled;
                      } else if (label == "Email") {
                        _isEmailEnabled = !_isEmailEnabled;
                      }
                    });
                  },
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
