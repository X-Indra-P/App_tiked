import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class SaldoUser extends StatefulWidget {
  final Map<String, dynamic> user;

  const SaldoUser({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<SaldoUser> createState() => _SaldoUserState();
}

class _SaldoUserState extends State<SaldoUser> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  late String nama;
  late String alamat;
  late String telepon;
  late String tglLahir;
  String saldo = '0';
  List<Map<String, dynamic>> transaksiHistory = [];

  @override
  void initState() {
    super.initState();
    nama = widget.user['nama'];
    alamat = widget.user['alamat'];
    telepon = widget.user['telepon'];
    tglLahir = widget.user['tgl_lahir'];

    getSaldo();
    getTransaksiHistory();
  }

  void getSaldo() async {
    try {
      final response = await dio.get(
        '$apiUrl/saldo/${widget.user['id']}',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
      );

      print(response.data);

      setState(() {
        saldo = response.data['data']['saldo'].toString();
      });
    } on DioError catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }

  void getTransaksiHistory() async {
    final response = await dio.get(
      '$apiUrl/tabungan/${widget.user['id']}',
      options: Options(
        headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
      ),
    );

    print(response);

    setState(() {
      transaksiHistory =
          List<Map<String, dynamic>>.from(response.data['data']['tabungan']);
    });
  }

  String getNominalWithSign(int trxId, int nominal) {
    switch (trxId) {
      case 1:
      case 2:
      case 5:
        return '+ Rp. ${NumberFormat.decimalPattern('id_ID').format(nominal)}';
      case 3:
      case 6:
        return '- Rp. ${NumberFormat.decimalPattern('id_ID').format(nominal)}';
      default:
        return 'Rp. ${NumberFormat.decimalPattern('id_ID').format(nominal)}';
    }
  }

  String getTransaksiDescription(int trxId) {
    switch (trxId) {
      case 1:
        return 'Setoran Awal';
      case 2:
        return 'Tambah Saldo';
      case 3:
        return 'Penarikan';
      case 5:
        return 'Koreksi Penambahan';
      case 6:
        return 'Koreksi Penarikan';
      default:
        return 'Transaksi';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const Text('Saldo Anggota'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.blue.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue.shade200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Anggota',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                        'Nama :',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        nama,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                    
                   Text(
                        'Telepon',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        telepon,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        'Alamat',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        alamat,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                    Text(
                        'Tanggal Lahir',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        tglLahir,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                    SizedBox(height: 10),
                    Text(
                      'Sisa Saldo',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Rp. ${NumberFormat.decimalPattern('id_ID').format(int.parse(saldo))}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Histori Transaksi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: transaksiHistory.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      leading: Icon(
                        Icons.attach_money,
                        color: transaksiHistory[index]['trx_id'] == 3 ||
                                transaksiHistory[index]['trx_id'] == 6
                            ? Colors.red
                            : Colors.green,
                      ),
                      title: Text(
                        getTransaksiDescription(
                            transaksiHistory[index]['trx_id']),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Tanggal: ${transaksiHistory[index]['trx_tanggal']}',
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: Text(
                        getNominalWithSign(
                            transaksiHistory[index]['trx_id'],
                            transaksiHistory[index]['trx_nominal']),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: transaksiHistory[index]['trx_id'] == 3 ||
                                  transaksiHistory[index]['trx_id'] == 6
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
