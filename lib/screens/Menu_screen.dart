import 'package:den_ecommerce/core/constant/den_theme.dart';
import 'package:den_ecommerce/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.024,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xff6785CC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1597957602900-97e95de20028?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8cG90cmFpdHN8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60"),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.032,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Arbin Paudel",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.012,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.mail,
                            size: 16,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.032,
                          ),
                          Text(
                            "itsarbin08@gmail.com",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.012,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 16,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.032,
                              ),
                              Text(
                                "9861333577",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.032,
                              ),
                              Text(
                                "Kirtipur",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.024,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Card(
                    elevation: 0,
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        "Change Profile",
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: ListTile(
                      leading: Icon(Icons.key),
                      title: Text(
                        "Change Password",
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Logout'),
                              content: Text('Are You Sure You Want to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Discard',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: DenTheme.secondaryColor,
                                    elevation: 0,
                                    padding: EdgeInsets.all(12),
                                  ),
                                  child: Text("Confirm"),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
