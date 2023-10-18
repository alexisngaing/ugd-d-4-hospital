import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String? name;
  final String? date;
  final String? email;
  final String? notelp;

  const Profile({Key? key, this.name, this.date, this.email, this.notelp})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Text("Nama : ${widget.name}"),
            Text("Email : ${widget.email}"),
            Text("Tanggal Lahir : ${widget.date}"),
            Text("No. Telp : ${widget.notelp}"),
          ],
        ),
      ),
    );
  }
}
