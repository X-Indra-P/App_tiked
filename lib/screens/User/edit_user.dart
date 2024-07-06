import 'package:app_tiked/screens/User/list_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class EditUser extends StatefulWidget {
  final Map<String, dynamic> user;

  const EditUser({
    super.key,
    required this.user,
  });

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  late TextEditingController noIndukController;
  late TextEditingController namaController;
  late TextEditingController alamatController;
  late TextEditingController tglLahirController;
  late TextEditingController teleponController;

  @override
  void initState() {
    super.initState();
    noIndukController =
        TextEditingController(text: widget.user['nomor_induk'].toString());
    namaController = TextEditingController(text: widget.user['nama']);
    alamatController = TextEditingController(text: widget.user['alamat']);
    tglLahirController = TextEditingController(text: widget.user['tgl_lahir']);
    teleponController = TextEditingController(text: widget.user['telepon']);
  }

  void updateUser() async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: 'Konfirmasi',
      desc: 'Apakah data yang disimpan sudah benar?',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        try {
          final response = await dio.put(
            '$apiUrl/anggota/${widget.user['id']}',
            options: Options(
              headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
            ),
            data: {
              'nomor_induk': noIndukController.text,
              'nama': namaController.text,
              'alamat': alamatController.text,
              'tgl_lahir': tglLahirController.text,
              'telepon': teleponController.text,
            },
          );

          print(response.data);

          // Show success dialog
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: 'Success',
            desc: 'Data berhasil diperbarui!',
            btnOkOnPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ListUser(),
                ),
              );
            },
          ).show();
        } on DioException catch (e) {
          print('${e.response} - ${e.response?.statusCode}');
        }
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const Text('Edit Data Anggota'),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 5),
              TextField(
                controller: noIndukController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Nomor Induk',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: const Color.fromARGB(128, 128, 128, 128),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF80DEEA), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: alamatController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF80DEEA), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: tglLahirController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF80DEEA), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: teleponController,
                decoration: InputDecoration(
                  labelText: 'Telephone',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF80DEEA), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  updateUser();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color.fromARGB(255, 14, 95, 161), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color(0xFF80DEEA),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
