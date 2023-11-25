import 'package:ugd_4_hospital/data/Booking.dart';
import 'package:ugd_4_hospital/database/API/BookingClient.dart';
import 'package:ugd_4_hospital/page/booking_input_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasienView extends ConsumerWidget {
  PasienView({super.key});

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  final listPasien = FutureProvider<List<Booking>>((ref) async {
    return await BookingClient.fetchAll();
  });

  void onAdd(context, ref) {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PasienInputPage()))
        .then((value) {
      _searchController.clear(); // Clear search when adding a new item
      ref.refresh(listPasien);
    });
  }

  void onSearch(context, ref, String query) async {
    var results = await BookingClient.search(query);
    searchResults = results
        .map((booking) =>
            booking.toJson()) // Convert to List<Map<String, dynamic>>
        .toList();
    ref.refresh(listPasien);
  }

  void onDelete(id, context, ref) async {
    try {
      await BookingClient.destroy(id);
      ref.refresh(listPasien);
      showSnackBar(context, "Delete Success", Colors.green);
    } catch (e) {
      showSnackBar(context, "Delete Failed", Colors.red);
    }
  }

  Card scrollViewItem(Booking b, context, ref) => Card(
        child: ListTile(
          title: Text(b.nama),
          subtitle: Text(b.deskripsi),
          leading: Image.asset('images/${b.picture}.jpeg'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PasienInputPage(id: b.id),
            ),
          ).then((value) => ref.refresh(listPasien)),
          trailing: IconButton(
            onPressed: () => onDelete(b.id, context, ref),
            icon: const Icon(Icons.delete),
          ),
        ),
      );

  List<Card> buildSearchResults(context, ref) {
    return searchResults
        .map((result) => scrollViewItem(Booking.fromJson(result), context, ref))
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listener = ref.watch(listPasien);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Booking"),
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
          if (_searchController.text.isNotEmpty)
            SingleChildScrollView(
              child: Column(
                children: buildSearchResults(context, ref),
              ),
            )
          else
            listener.when(
              data: (bookings) => SingleChildScrollView(
                child: Column(
                    children: bookings
                        .map((book) => scrollViewItem(book, context, ref))
                        .toList()),
              ),
              error: (err, s) => Center(child: Text(err.toString())),
              loading: () => const Center(
                child: CircularProgressIndicator(),
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