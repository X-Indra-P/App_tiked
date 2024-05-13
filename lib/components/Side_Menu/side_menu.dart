import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
        width: 288,
        height: double.infinity,
        color: Color(0x17203A),
        child: SafeArea(
          child: Column(
            children: [Infocard(
              name: "Saxony.", 
              profession: "Mahasiswa",
              ),
            ],
            ),
        ),
        ),
      ),
    );
  }
}

class Infocard extends StatelessWidget {
  const Infocard({
    super.key, 
    required this.name, 
    required this.profession,
  });

  final String name, profession;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(CupertinoIcons.person),
        ),
        title: Text(
          name,
          style: TextStyle(
            color: Colors.white),
          ),
          subtitle: Text(
            profession, 
            style: TextStyle(
              color: Colors.white),
              ),
    );
  }
}