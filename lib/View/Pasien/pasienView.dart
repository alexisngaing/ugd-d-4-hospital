import 'package:flutter_svg/svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_4_hospital/View/home.dart';
import 'package:ugd_4_hospital/model/Booking.dart';
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
      _searchController.clear();
      ref.refresh(listPasien);
    });
  }

  void onSearch(context, ref, String query) async {
    var results = await BookingClient.search(query);
    searchResults = results.map((booking) => booking.toJson()).toList();
    ref.refresh(listPasien);
  }

  void onDelete(id, context, ref) async {
    try {
      await BookingClient.destroy(id);
      ref.refresh(listPasien);
      showSnackBar(
          context, "Delete Success", Colors.green, const Duration(seconds: 2));
    } catch (e) {
      showSnackBar(
          context, "Delete Failed", Colors.red, const Duration(seconds: 2));
    }
  }

  Card scrollViewItem(Booking b, context, ref) => Card(
        child: ListTile(
          key: ValueKey('pasien_${b.id}'),
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
        backgroundColor: const Color(0xff15C73C),
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
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff15C73C),
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
              data: (bookings) {
                if (bookings.isNotEmpty) {
                  return SingleChildScrollView(
                    child: Column(
                        children: bookings
                            .map((book) => scrollViewItem(book, context, ref))
                            .toList()),
                  );
                } else {
                  return Container(
                    width: 90.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Positioned(
                          child: SvgPicture.asset(
                            "images/sad-female.svg",
                            height: 40.h,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: RichText(
                            text: TextSpan(
                              text:
                                  'Maaf. Kamu belum mendaftar konsultasi apapun',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              error: (err, s) => Center(child: Text(err.toString())),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}

void showSnackBar(BuildContext context, String msg, Color bg, Duration dr) {
  final scaffold = ScaffoldMessenger.of(context);

  scaffold.showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: bg,
      action: SnackBarAction(
          label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
      duration: dr,
    ),
  );
}
