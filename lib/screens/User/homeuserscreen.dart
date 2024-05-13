import 'package:app_tiked/components/Side_Menu/side_menu.dart';
import 'package:app_tiked/screens/User/add_user.dart';
import 'package:app_tiked/screens/User/list_user.dart';
import 'package:app_tiked/size_config.dart';
import 'package:app_tiked/utils/constants.dart';
import 'package:flutter/material.dart';


class HomeUserScreen extends StatelessWidget {
  const HomeUserScreen({super.key});

  static String routeName = "/home_user";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        title: const Text("Home Screen", style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold ),
        ),
        leading: const Icon(
          Icons.home, 
          color: mTitleColor,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.person, 
              color: mTitleColor,
              ),
          ),
        const  SizedBox(width: 10,
          )
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(child: const Text("Selamat Datang Kawan",),),

            const SizedBox(height: 20),
            ElevatedButton(
              // tombol list user
              onPressed: () {
                // Balik ke halaman login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddUser(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  'Tambah User',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

             const SizedBox(height: 20),
            ElevatedButton(
              // tombol list user
              onPressed: () {
                // Balik ke halaman login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListUser(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  'Lihat List User',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}