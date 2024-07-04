import 'package:flutter/material.dart';
import 'package:app_tiked/screens/Login/loginscreens.dart';
import 'package:app_tiked/screens/User/add_user.dart';
import 'package:app_tiked/screens/User/list_transaksi.dart';
import 'package:app_tiked/screens/User/list_user.dart';
import 'package:app_tiked/screens/User/profile.dart';
import 'package:app_tiked/utils/constants.dart';
import 'package:dio/dio.dart';

class HomeUserScreen extends StatelessWidget {
  const HomeUserScreen({super.key});

  static String routeName = "/home_user";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blue.shade100,
        title: const Text(
          "Home Screen",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
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
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "-WELCOME-",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: mTitleColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(
                      context,
                      icon: Icons.person_add,
                      text: 'Tambah Anggota',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddUser(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildButton(
                      context,
                      icon: Icons.list,
                      text: 'List Anggota',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListUser(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildButton(
                      context,
                      icon: Icons.receipt,
                      text: 'Transaksi',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListTransaksi(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildButton(
                      context,
                      icon: Icons.logout,
                      text: 'LogOut',
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, LoginScreens.routeName);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              DashboardSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kFourthColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: "List Anggota",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_sharp),
            label: "Profil",
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ListUser(),
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required IconData icon, required String text, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: Colors.white),
      label: Text(text, textAlign: TextAlign.center),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(100, 100),
        foregroundColor: Colors.white,
        backgroundColor: kColorTealToSlow,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class DashboardSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: [
          _buildDashboardItem(
            icon: Icons.campaign,
            label: "Informasi",
            onTap: () {},
          ),
          _buildDashboardItem(
            icon: Icons.bar_chart,
            label: "Statistics",
            onTap: () {},
          ),
          _buildDashboardItem(
            icon: Icons.notifications,
            label: "Notifications",
            onTap: () {},
          ),
          _buildDashboardItem(
            icon: Icons.settings,
            label: "Settings",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardItem(
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: kColorTealToSlow,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kColorTealToSlow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void goLogout(BuildContext context, dio, myStorage, apiUrl) async {
  try {
    final response = await dio.get(
      '$apiUrl/logout',
      options: Options(
        headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
      ),
    );
    print(response.data);

    myStorage.remove('token');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreens()),
    );
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}
