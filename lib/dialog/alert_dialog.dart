import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/View/login.dart';
import 'package:ugd_4_hospital/View/register.dart';

showAlertDialog(BuildContext context) {
  // pengaturan tombol alert
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      pushRegister(context);
    },
  );
  Widget okButton = TextButton(
    child: Text("Ok"),
    onPressed: () {
      pushLogin(context);
    },
  );

  // isi teks alertnya
  AlertDialog alert = AlertDialog(
    title: Text("[!] WARNING!"),
    content: Text("Pastikan data yang anda isi telah benar"),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // cara nampilinnya, kaitin sama tombol sumbit di registrasi
  // nanti tombol ok bakal nerusin ke data dikirim, klo cancel ya batal
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void pushRegister(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const RegisterView(),
    ),
  );
}

void pushLogin(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const LoginPage(),
    ),
  );
}
