import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_4_hospital/View/Pelayanan/Transaksi/list_obat.dart';

class Checkout3 extends StatefulWidget {
  const Checkout3({super.key});

  @override
  State<Checkout3> createState() => _Checkout3State();
}

class _Checkout3State extends State<Checkout3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pembayaran Diterima',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff15C73C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Checkout1()),
            );
          },
        ),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Card(
                child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Image.network(
                  "https://static.vecteezy.com/system/resources/previews/002/264/860/non_2x/receiving-online-payment-vector.jpg",
                  fit: BoxFit.cover,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Yuhu!,",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "pembayaran kamu diterima.",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
