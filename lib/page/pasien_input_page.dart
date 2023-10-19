import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ugd_4_hospital/database/sql_helper.dart';
import 'package:ugd_4_hospital/data/pasien.dart';
import 'package:ugd_4_hospital/View/home.dart';

class PasienInputPage extends StatefulWidget {
  const PasienInputPage({
    Key? key,
    this.title,
    this.nama,
    this.umur,
    this.picture,
    this.deskripsi,
    this.id,
  }) : super(key: key);

  final String? title;
  final String? nama;
  final String? deskripsi;
  final String? picture;
  final int? umur;
  final int? id;

  @override
  State<PasienInputPage> createState() => _PasienInputPageState();
}

class _PasienInputPageState extends State<PasienInputPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerDeskripsi = TextEditingController();
  TextEditingController controllerPicture = TextEditingController();
  TextEditingController controllerUmur = TextEditingController();

  Widget build(BuildContext context) {
    if (widget.id != null) {
      controllerNama.text = widget.nama!;
      controllerDeskripsi.text = widget.deskripsi!;
      controllerPicture.text = widget.picture!;
      controllerUmur.text = widget.umur!.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
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
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              controller: controllerNama,
              validator: (value) =>
                  value == '' ? 'Nama Tidak boleh kosong' : null,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.people_alt_outlined),
                labelText: 'Nama Pasien',
                hintText: 'Isikan Nama anda...',
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: controllerUmur,
              validator: (value) =>
                  value == '' ? 'Umur tidak boleh kosong' : null,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Umur',
                hintText: 'Isikan Umur anda..',
                prefixIcon: Icon(Icons.numbers_outlined),
              ),
            ),
            TextFormField(
              controller: controllerDeskripsi,
              validator: (value) =>
                  value == '' ? 'Harus Mengisi Deskripsi Penyakit' : null,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.description_outlined),
                border: UnderlineInputBorder(),
                labelText: 'Deskripsi',
                hintText: 'Isikan Deskripsi Penyakit anda..',
              ),
            ),
            TextFormField(
              controller: controllerPicture,
              validator: (value) => value == '' ? 'Must not be empty' : null,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Dokter',
                  hintText: 'Masukan Nama Dokter anda..',
                  prefixIcon: Icon(Icons.picture_in_picture_outlined)),
            ),
            const SizedBox(
              height: 48,
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  if (widget.id == null) {
                    await addPasien();
                  } else {
                    await editPasien(widget.id!);
                  }
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addPasien() async {
    await SQLHelper.addPasien(Pasien(
        nama: controllerNama.text,
        deskripsi: controllerDeskripsi.text,
        umur: int.tryParse(controllerUmur.text),
        picture: controllerPicture.text));
  }

  Future<void> editPasien(int id) async {
    await SQLHelper.editPasien(
        id,
        Pasien(
            nama: controllerNama.text,
            deskripsi: controllerDeskripsi.text,
            umur: int.tryParse(controllerUmur.text),
            picture: controllerPicture.text));
  }
}
