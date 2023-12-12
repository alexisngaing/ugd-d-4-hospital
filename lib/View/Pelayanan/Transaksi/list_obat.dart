import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_4_hospital/View/Pelayanan/Transaksi/checkout_berhasil.dart';
import 'package:ugd_4_hospital/View/Pelayanan/Transaksi/checkout_obat.dart';
import 'package:ugd_4_hospital/View/Pelayanan/obat_obatan.dart';

class Checkout1 extends StatefulWidget {
  const Checkout1({Key? key}) : super(key: key);

  @override
  State<Checkout1> createState() => _Checkout1State();
}

class _Checkout1State extends State<Checkout1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Obat-obatan',
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
              MaterialPageRoute(builder: (context) => const ObatView()),
            );
          },
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              // Container Sakit Kepala
              Center(
                child: Container(
                  width: 90.w,
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
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: const Color(0xff15C73C),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.headSideVirus,
                              size: 22.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            child: Text(
                              "Sakit Kepala",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CheckoutObat()),
                        );
                      },
                      child: Container(
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  'https://lirp.cdn-website.com/0ead930f/dms3rep/multi/opt/PARACETAMOL-500-MG-TABLET-640w.jpg',
                                  fit: BoxFit.fill,
                                  width: 200,
                                  height: 130,
                                ),
                              ),
                              SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 5),
                                      Text(
                                        'Paracetamol 500 mg',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 5),
                                          Text("Per Strip"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 5),
                                          Text(
                                            "Rp. 10.000",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 50),
                                          FaIcon(
                                            FontAwesomeIcons.plus,
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                'https://ui.assets-asda.com/dm/5017353504753',
                                fit: BoxFit.fill,
                                width: 200,
                                height: 130,
                              ),
                            ),
                            SizedBox(height: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 5),
                                    Text(
                                      'Aspirin 75 mg',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 5),
                                        Text("Per Pac"),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 5),
                                        Text(
                                          "Rp. 70.000",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                        FaIcon(
                                          FontAwesomeIcons.plus,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                'https://res-2.cloudinary.com/dk0z4ums3/image/upload/c_scale,h_500,w_500/v1/production/pharmacy/products/1655552097_61dc0ab2f2c0e80587f7a9c2',
                                fit: BoxFit.fill,
                                width: 200,
                                height: 130,
                              ),
                            ),
                            SizedBox(height: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 5),
                                    Text(
                                      'Ibuprofen 400 mg',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 5),
                                        Text("Per Strip"),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 5),
                                        Text(
                                          "Rp. 14.000",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                        FaIcon(
                                          FontAwesomeIcons.plus,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                'https://res-4.cloudinary.com/dk0z4ums3/image/upload/c_scale,h_500,w_500/v1/production/pharmacy/products/1660368050_5fb3751941ab59059e86732d',
                                fit: BoxFit.fill,
                                width: 200,
                                height: 130,
                              ),
                            ),
                            SizedBox(height: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        'Asam Mefenamat 500 mg',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 5),
                                        Text("Per Strip"),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 5),
                                        Text(
                                          "Rp. 18.000",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                        FaIcon(
                                          FontAwesomeIcons.plus,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 150,
              ),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Checkout3()),
                        );
                      },
                      child: FaIcon(
                        FontAwesomeIcons.moneyBill1Wave,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 280,
                    ),
                    GestureDetector(
                      // GANTI CHECKOUT 3 KE PAGE STF CLASS CHECKOUT 2
                      //            onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => Checkout3(

                      //     ),
                      //     ),
                      //   );
                      // },
                      child: FaIcon(
                        FontAwesomeIcons.cartShopping,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
