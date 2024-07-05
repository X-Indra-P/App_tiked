import 'package:app_tiked/screens/User/homeuserscreen.dart';
import 'package:app_tiked/screens/User/list_user.dart';
import 'package:app_tiked/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart'; 
import 'package:awesome_dialog/awesome_dialog.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  TextEditingController noIndukController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tglLahirController = TextEditingController();
  TextEditingController teleponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
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
        title: Text(
          'Tambahkan Data Anggota',
          style: TextStyle(color: kFourthColor, fontWeight: FontWeight.bold),
        ),
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
            children: [
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: noIndukController,
                decoration: InputDecoration(
                  labelText: 'Nomor Induk',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF80DEEA),
                      width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
                    borderSide: const BorderSide(
                      color: Color(0xFF80DEEA),
                      width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
                    borderSide: const BorderSide(
                      color: Color(0xFF80DEEA),
                      width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
                    borderSide: const BorderSide(
                      color: Color(0xFF80DEEA),
                      width: 2),
                  ),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode()); // To prevent keyboard from appearing
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1600),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      tglLahirController.text = formattedDate;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
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
                    borderSide: const BorderSide(
                      color: Color(0xFF80DEEA),
                      width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  addUser(
                    context,
                    dio,
                    myStorage,
                    apiUrl,
                    noIndukController,
                    namaController,
                    alamatController,
                    tglLahirController,
                    teleponController,
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color.fromARGB(255, 14, 95, 161),
                      width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(0xFF80DEEA),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void addUser(
  BuildContext context,
  dio,
  myStorage,
  apiUrl,
  noIndukController,
  namaController,
  alamatController,
  tglLahirController,
  teleponController,
) async {
  try {
    final response = await dio.post(
      '$apiUrl/anggota',
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
      desc: 'User added successfully!',
      btnOkOnPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListUser()),
        );
      },
    )..show();
  } on DioException catch (e) {
    if (e.response?.statusCode == 405) { // Conflict status code
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        desc: 'Nomor Induk sudah ada.',
        btnOkOnPress: () {},
      )..show();
    } else {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }
}
