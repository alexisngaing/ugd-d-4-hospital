import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_4_hospital/View/Pelayanan/Transaksi/checkout_berhasil.dart';

class CheckoutObat extends StatefulWidget {
  const CheckoutObat({super.key});

  @override
  State<CheckoutObat> createState() => _CheckoutObatState();
}

class _CheckoutObatState extends State<CheckoutObat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        backgroundColor: const Color(0xff15C73C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Container(
              padding: const EdgeInsets.all(15),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alamat Pengiriman',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Colors.black54,
                              size: 20.sp,
                            ),
                            SizedBox(width: 1.w),
                            Container(
                                width: 60.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Jl. Laksda Adisucipto, Ambarukmo, Caturtunggal, Kec. Depok, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55281',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                      softWrap: true,
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      'Seberang Plaza Ambarrukmo',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14.sp,
                                      ),
                                      softWrap: true,
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              padding: const EdgeInsets.all(15),
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
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_pharmacy_outlined,
                        color: Colors.black,
                        size: 20.sp,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'K24 Babarsari',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.black12,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Container(
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            "images/paracetamol.jpg",
                            width: 19.w,
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Paracetamol 500 mg',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                              softWrap: true,
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'Per Strip',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                              softWrap: true,
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'Rp 10.000,-',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.delete_forever_rounded,
                            size: 18.sp,
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(width: 2),
                        IconButton(
                          onPressed: () {
                            // setState(() => currentProduct.amount--);
                          },
                          icon: Icon(Icons.remove, size: 16.sp),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 10.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text("2"
                              // currentProduct.amount.toString(),
                              // textAlign: TextAlign.center,
                              ),
                        ),
                        IconButton(
                          onPressed: () {
                            // setState(() => currentProduct.amount++);
                          },
                          icon: Icon(
                            Icons.add,
                            size: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.black12,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Kurir Pengiriman',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black26,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  "images/grab.jpg",
                                  width: 12.w,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Grab Instant',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Text(
                                    'Akan diterima paling lambat dalam 1 jam.',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                    softWrap: true,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 2.h),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xff0C1B6F),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.plus,
                      color: const Color(0xff0C1B6F),
                      size: 15.sp,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Tambah Barang lainnya',
                      style: TextStyle(
                        color: const Color(0xff0C1B6F),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              padding: const EdgeInsets.all(15),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ringkasan Pembelian',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Total Harga',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Rp 20.000,-',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Text(
                              'Ongkos Kirim',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Rp 15.000,-',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Text(
                              'Biaya Layanan',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Rp 5.000,-',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Text(
                              'Diskon Pengguna Baru',
                              style: TextStyle(
                                color: const Color(0xff0C1B6F),
                                fontSize: 14.sp,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Rp 10.000,-',
                              style: TextStyle(
                                color: const Color(0xff0C1B6F),
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          decoration: const BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                color: Colors.black12,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Text(
                              'Total Pembayaran',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Rp 30.000,-',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 10.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Pembayaran',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Rp 30.000,-',
                    style: TextStyle(
                      color: Color(0xff15C73C),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                width: 30.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: const Color(0xff15C73C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const Checkout3()),
                    );
                  },
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
