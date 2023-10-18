import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/View/login.dart';
import 'package:ugd_4_hospital/View/register.dart';

showDialogGagal(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("Ok"),
    onPressed: () {
      pushRegister(context);
    },
  );

  // isi teks alertnya
  AlertDialog alert = AlertDialog(
    title: Text("[!] WARNING!"),
    content: Text("Isi Semua data"),
    actions: [
      okButton,
    ],
  );
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
