import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/database/sql_helper.dart';
import 'package:ugd_4_hospital/page/pasien_input_page.dart';
import 'package:ugd_4_hospital/View/home.dart';

class PasienView extends StatefulWidget {
  const PasienView({super.key});

  @override
  State<PasienView> createState() => _PasienViewState();
}

class _PasienViewState extends State<PasienView> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> pasienPasien = [];

  void refresh(String search) async {
    final data = await SQLHelper.getPasien(search);
    setState(() {
      pasienPasien = data;
    });
  }

  @override
  void initState() {
    refresh('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Konsul Dokter'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PasienInputPage(
                  title: 'Daftar Diri',
                  id: null,
                  nama: null,
                  deskripsi: null,
                  umur: null,
                  picture: null),
            ),
          ).then((value) => refresh(''));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 225, 225, 225),
                    width: 0.5,
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    onChanged: (value) {
                      refresh(value);
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                            refresh('');
                          });
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: pasienPasien.isEmpty
                  ? const Center(
                      child: Text('Tidak Ada daftar pemeriksaan'),
                    )
                  : ListView.builder(
                      itemCount: pasienPasien.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: InkWell(
                            splashColor: Colors.green,
                            onTap: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'images/${pasienPasien[index]['picture']}.jpeg'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          pasienPasien[index]['nama'],
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          'Umur:  ${pasienPasien[index]['umur']}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          pasienPasien[index]['deskripsi'],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      showCupertinoModalPopup(
                                        context: context,
                                        builder: ((context) =>
                                            CupertinoActionSheet(
                                              actions: <CupertinoActionSheetAction>[
                                                CupertinoActionSheetAction(
                                                  child: const Text(
                                                      'Edit Booking'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PasienInputPage(
                                                          title:
                                                              'Edit Data Booking',
                                                          id: pasienPasien[
                                                              index]['id'],
                                                          nama: pasienPasien[
                                                              index]['nama'],
                                                          deskripsi:
                                                              pasienPasien[
                                                                      index]
                                                                  ['deskripsi'],
                                                          picture: pasienPasien[
                                                              index]['picture'],
                                                          umur: pasienPasien[
                                                              index]['umur'],
                                                        ),
                                                      ),
                                                    ).then(
                                                        (value) => refresh(''));
                                                  },
                                                ),
                                                CupertinoActionSheetAction(
                                                  child: const Text(
                                                    'Delete Data Booking',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () async {
                                                    await deletePasien(
                                                        pasienPasien[index]
                                                            ['id']);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            )),
                                      );
                                    },
                                    icon: const Icon(Icons.more_vert),
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
    );
  }

  Future<void> deletePasien(int id) async {
    await SQLHelper.deletePasien(id);
    refresh('');
  }
}
