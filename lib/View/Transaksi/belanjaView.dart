import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd_4_hospital/model/Belanja.dart';
import 'package:ugd_4_hospital/database/API/BelanjaClient.dart';
import 'package:ugd_4_hospital/page/belanja_input_page.dart';

class BelanjaView extends ConsumerWidget {
  BelanjaView({super.key});

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  final listPasien = FutureProvider<List<Belanja>>((ref) async {
    return await BelanjaClient.fetchAll();
  });

  void onAdd(context, ref) {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TransaksiInputPage()))
        .then((value) {
      _searchController.clear();
      ref.refresh(listPasien);
    });
  }

  void onSearch(context, ref, String query) async {
    var results = await BelanjaClient.search(query);
    searchResults = results.map((booking) => booking.toJson()).toList();
    ref.refresh(listPasien);
  }

  void onDelete(id, context, ref) async {
    try {
      await BelanjaClient.destroy(id);
      ref.refresh(listPasien);
      showSnackBar(context, "Delete Success", Colors.green);
    } catch (e) {
      showSnackBar(context, "Delete Failed", Colors.red);
    }
  }

  Card scrollViewItem(Belanja b, context, ref) => Card(
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransaksiInputPage(id: b.id),
            ),
          ).then((value) => ref.refresh(listPasien)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(b.nama,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(b.deskripsi),
                      Text(b.alamat),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => onDelete(b.id, context, ref),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      );

  List<Widget> buildSearchResults(context, ref) {
    if (searchResults.isEmpty && _searchController.text.isNotEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Data Tidak Ditemukan",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ];
    } else {
      return searchResults
          .map((result) =>
              scrollViewItem(Belanja.fromJson(result), context, ref))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listener = ref.watch(listPasien);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Belanja"),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () => onAdd(context, ref),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) => onSearch(context, ref, query),
              decoration: InputDecoration(
                labelText: 'Search by name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: _searchController.text.isNotEmpty
                  ? buildSearchResults(context, ref)
                  : listener.when(
                      data: (bookings) => bookings
                          .map((book) => scrollViewItem(book, context, ref))
                          .toList(),
                      error: (err, s) => [
                        Center(child: Text(err.toString())),
                      ],
                      loading: () => [
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

void showSnackBar(BuildContext context, String msg, Color bg) {
  final scaffold = ScaffoldMessenger.of(context);

  scaffold.showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: bg,
      action: SnackBarAction(
          label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
