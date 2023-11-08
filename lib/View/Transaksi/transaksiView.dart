import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/database/sql_helper_transaksi.dart';
import 'package:ugd_4_hospital/page/transaksi_input_page.dart';
import 'package:ugd_4_hospital/View/home.dart';

class TransaksiView extends StatefulWidget {
  const TransaksiView({super.key});

  @override
  State<TransaksiView> createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> transaksiData = [];

  void refresh(String search) async {
    final data = await SQLHelper.getTransaksi(search);
    setState(() {
      transaksiData = data;
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
        title: const Text('Daftar Transaksi'),
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
              builder: (context) => const TransaksiInputPage(
                title: 'Pembelian Obat',
                id: null,
                nama: null,
                deskripsi: null,
                alamat: null,
              ),
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
              child: transaksiData.isEmpty
                  ? const Center(
                      child: Text('Tidak Ada daftar Pembelian'),
                    )
                  : ListView.builder(
                      itemCount: transaksiData.length,
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
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          transaksiData[index]['nama'],
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          transaksiData[index]['deskripsi'],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          transaksiData[index]['alamat'],
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
                                                      'Edit Transaksi'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            TransaksiInputPage(
                                                          title:
                                                              'Edit Data Booking',
                                                          id: transaksiData[
                                                              index]['id'],
                                                          nama: transaksiData[
                                                              index]['nama'],
                                                          deskripsi:
                                                              transaksiData[
                                                                      index]
                                                                  ['deskripsi'],
                                                          alamat: transaksiData[
                                                              index]['alamat'],
                                                        ),
                                                      ),
                                                    ).then(
                                                        (value) => refresh(''));
                                                  },
                                                ),
                                                CupertinoActionSheetAction(
                                                  child: const Text(
                                                    'Batal Beli Transaksi',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () async {
                                                    await deleteTransaksi(
                                                        transaksiData[index]
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

  Future<void> deleteTransaksi(int id) async {
    await SQLHelper.deleteTransaksi(id);
    refresh('');
  }
}
