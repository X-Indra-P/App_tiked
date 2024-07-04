import 'package:app_tiked/screens/User/list_transaksi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AddTransaksi extends StatefulWidget {
  final Map<String, dynamic> user;
  const AddTransaksi({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<AddTransaksi> createState() => _AddTransaksiState();
}

class _AddTransaksiState extends State<AddTransaksi> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  TextEditingController idAnggotaController = TextEditingController();
  TextEditingController trxNominalController = TextEditingController();
  int? selectedTrxId;

  @override
  void initState() {
    super.initState();
    idAnggotaController = TextEditingController(
      text: widget.user['id'].toString(),
    );
    selectedTrxId = 1;
  }

  void menuTransaksi() async {
    try {
      final response = await dio.post(
        '$apiUrl/tabungan',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
        data: {
          'anggota_id': idAnggotaController.text,
          'trx_id': selectedTrxId.toString(),
          'trx_nominal': trxNominalController.text,
        },
      );

      print(response.data);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListTransaksi(),
        ),
      );
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Transaksi'),
        backgroundColor: Colors.blue.shade100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ListTransaksi(),
              ),
            );
          },
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              // Text field for displaying user's name
              TextFormField(
                enabled: false,
                controller: TextEditingController(text: widget.user['nama']),
                decoration: const InputDecoration(
                  labelText: 'Nama Anggota',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  fillColor: Color.fromARGB(255, 240, 240, 240),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Text field for entering transaction amount
              TextFormField(
                controller: trxNominalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Nominal Transaksi',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  prefixText: 'Rp. ',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF80DEEA), width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Dropdown for selecting transaction type
              DropdownButtonFormField<int>(
                value: selectedTrxId,
                items: const [
                  DropdownMenuItem<int>(
                    value: 1,
                    child: Text('Setoran Awal'),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: Text('Tambah Saldo'),
                  ),
                  DropdownMenuItem<int>(
                    value: 3,
                    child: Text('Tarik Saldo'),
                  ),
                  DropdownMenuItem<int>(
                    value: 5,
                    child: Text('Koreksi Penambahan'),
                  ),
                  DropdownMenuItem<int>(
                    value: 6,
                    child: Text('Koreksi Pengurangan'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedTrxId = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              // Button for saving transaction
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    menuTransaksi();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color.fromARGB(255, 14, 95, 161),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xFF80DEEA),
                  ),
                  child: const Text(
                    'Simpan',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
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
