import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class Mahasiswa {
  final String nim;
  final String name;

  Mahasiswa(this.nim, this.name);
}

class Lokasi {
  final String nama;
  final String geocode;
  final String jarak;

  Lokasi(this.nama, this.geocode, this.jarak);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Mahasiswa? selectedOption;

  Lokasi? lokasiOption;

  List<Lokasi> loptions = [
    Lokasi("Gpay Digital Asia", "106.818421%2C+-6.210845", "27632.49")
  ];

  List<Mahasiswa> options = [
    Mahasiswa('2204001', 'Adam Musyafa Adipratama'),
    Mahasiswa('2204002', 'Ahmad Djanuardi Kustari'),
    Mahasiswa('2204003', 'Ahmad Hariadi'),
    Mahasiswa('2204004', 'Alfi Dwi Octavian'),
    Mahasiswa('2204005', 'Alief Elza Putra'),
    Mahasiswa('2204006', 'Arthea Alitta Yona Fisca'),
    Mahasiswa('2204007', 'Aswin Khairu Adnan'),
    Mahasiswa('2204008', 'Bagas Tri Hendrawan'),
    Mahasiswa('2204009', 'Diki Candra Maulana'),
    Mahasiswa('2204010', 'Fatha Ghani Al Rauf'),
    Mahasiswa('2204011', 'Ferdian Aria Finanta'),
    Mahasiswa('2204012', 'Gilang Romadhan'),
    Mahasiswa('2204013', 'Hidayat Noerwahid'),
    Mahasiswa('2204014', 'Ibnu Saifullah'),
    Mahasiswa('2204015', 'Luthfi Rizqi Septama Nugraha'),
    Mahasiswa('2204016', 'Mochamad One Sopyan'),
    Mahasiswa('2204017', 'Mochammad Iqbal Rizqulloh'),
    Mahasiswa('2204018', 'Muhamad Fortuna Dwi Nugroho'),
    Mahasiswa('2204019', 'Muhamad Yusril Arrojak'),
    Mahasiswa('2204020', 'Muhammad Ayom Izzuddin'),
    Mahasiswa('2204021', 'Muhammad Fakhri Erlangga'),
    Mahasiswa('2204022', 'Muhammad Syaifullah Fajri'),
    Mahasiswa('2204023', 'Mukhamad Syafiqul Amin'),
    Mahasiswa('2204024', 'Nanang Adi Utomo'),
    Mahasiswa('2204025', 'Nanang Pratama'),
    Mahasiswa('2204026', 'Nanang Priambudi'),
    Mahasiswa('2204027', 'Nur Ikhsan Ramdhani'),
    Mahasiswa('2204028', 'Rafli Yudistira'),
    Mahasiswa('2204029', 'Wisfie Syahbani'),
    Mahasiswa('2204030', 'Wisnu Buana Sakti'),
  ];

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse('https://sisfo.poltek-gt.ac.id/app/');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void sendData(test) async {
    var url = Uri.parse('https://sisfo.poltek-gt.ac.id/student/insert_absen');

    //PULANG
    //H
    var data = {
      'NIM': selectedOption?.nim,
      'NAMA': selectedOption?.name,
      'GROUP': '32',
      'PENEMPATAN': '1',
      'GEOCODE': lokasiOption?.geocode,
      'JARAK': lokasiOption?.jarak,
      'TANGGAL': DateFormat('dd/MM/yyyy').format(selectedDate),
      'KET': 'H',
      'func': test,
    };

    var response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      print(response.statusCode);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // selectedOption = options[20];
    // lokasiOption = loptions[0];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Text("NIM"),
                Container(
                  width: 350,
                  child: DropdownButton<Mahasiswa>(
                    value: selectedOption,
                    onChanged: (Mahasiswa? newValue) {
                      setState(() {
                        selectedOption = newValue;
                      });
                    },
                    items: options.map<DropdownMenuItem<Mahasiswa>>(
                      (Mahasiswa option) {
                        return DropdownMenuItem<Mahasiswa>(
                          value: option,
                          child: Text(option.name),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Lokasi"),
                Container(
                  width: 350,
                  child: DropdownButton<Lokasi>(
                    value: lokasiOption,
                    onChanged: (Lokasi? newValue) {
                      setState(() {
                        lokasiOption = newValue;
                      });
                    },
                    items: loptions.map<DropdownMenuItem<Lokasi>>(
                      (Lokasi option) {
                        return DropdownMenuItem<Lokasi>(
                          value: option,
                          child: Text(option.nama),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Tanggal"),
                Container(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Select Date'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      sendData('Simpan');
                    },
                    child: Text("Masuk")),
                ElevatedButton(
                    onPressed: () {
                      sendData('PULANG');
                    },
                    child: Text("Pulang"))
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _launchUrl,
        tooltip: 'Cek Absen',
        child: const Icon(Icons.add),
      ),
    );
  }
}
