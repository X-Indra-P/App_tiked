import 'package:app_tiked/screens/User/add_transaksi.dart';
import 'package:app_tiked/screens/User/homeuserscreen.dart';
import 'package:app_tiked/screens/User/saldo_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ListTransaksi extends StatefulWidget {
  const ListTransaksi({super.key});

  @override
  State<ListTransaksi> createState() => _ListTransaksiState();
}

class _ListTransaksiState extends State<ListTransaksi> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';
  List<dynamic> users = [];
  List<dynamic> filteredUsers = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAnggota();
  }

  void getAnggota() async {
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

  void tambahTransaksi(Map<String, dynamic> user) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTransaksi(user: user),
      ),
    );
  }

  void goSaldo(Map<String, dynamic> user) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SaldoUser(user: user),
      ),
    );
  }

  void filterUsers(String query) {
    setState(() {
      filteredUsers = users
          .where((user) =>
              user['nama'].toString().toLowerCase().contains(query.toLowerCase()) ||
              user['nomor_induk'].toString().toLowerCase().contains(query.toLowerCase())||
              user['tgl_lahir'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const Text('List Transaksi Anggota'),
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
              SizedBox(height: 20), // Adjusted the height
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
              SizedBox(height: 20), // Adjusted the height
              Expanded(
                child: filteredUsers.isEmpty
                    ? const Center(child: Text('Tidak Ada Anggota'))
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
                                      tambahTransaksi(user);
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text(
                                          'Tambah',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        Text(
                                          'Transaksi',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      goSaldo(user);
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text(
                                          'Lihat',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        Text(
                                          'Saldo',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ],
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
