import 'package:app_tiked/screens/User/edit_user.dart';
import 'package:app_tiked/screens/User/homeuserscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ListUser extends StatelessWidget {
  const ListUser({super.key});

  @override
  Widget build(BuildContext context) {
    return _ListUserScreen();
  }
}

class _ListUserScreen extends StatefulWidget {
  @override
  State<_ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<_ListUserScreen> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  List<dynamic> users = [];
  List<dynamic> filteredUsers = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    try {
      final response = await dio.get(
        '$apiUrl/anggota',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
      );

      setState(() {
        users = response.data['data']['anggotas'];
        filteredUsers = users; // Initialize filteredUsers with all users
      });
    } on DioError catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }

  void deleteUser(int id) async {
    try {
      final response = await dio.delete(
        '$apiUrl/anggota/$id',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
      );

      print(response.data);

      getUser();
    } on DioError catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }

  void editUser(Map<String, dynamic> user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditUser(user: user)),
    );
  }

  void filterUsers(String query) {
    setState(() {
      filteredUsers = users
          .where((user) => user['nomor_induk']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const Text('List Anggota'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeUserScreen(),
              ),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Cari Anggota',
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  filterUsers(value);
                },
              ),
              SizedBox(height: 20),
              Expanded(
                child: filteredUsers.isEmpty
                    ? Center(child: Text('Tidak Ada Anggota'))
                    : ListView.builder(
                        itemCount: filteredUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          final user = filteredUsers[index];
                          return Card(
                            child: ListTile(
                              title: Text(user['nama']),
                              subtitle: Text(user['tgl_lahir']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      editUser(user);
                                    },
                                    child: const Text(
                                      'Edit Anggota',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteUser(user);
                                    },
                                    child: const Text(
                                      'Hapus Anggota',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
