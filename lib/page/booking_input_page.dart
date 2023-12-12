import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ugd_4_hospital/View/Pasien/pasienView.dart';
import 'package:ugd_4_hospital/model/Booking.dart';
import 'package:ugd_4_hospital/database/API/BookingClient.dart';

class PasienInputPage extends StatefulWidget {
  const PasienInputPage({super.key, this.id});
  final int? id;

  @override
  State<PasienInputPage> createState() => _PasienInputPageState();
}

class _PasienInputPageState extends State<PasienInputPage> {
  final _fromKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final umurController = TextEditingController();
  final pictureController = TextEditingController();
  String? selectedDoctor;
  bool isLoading = false;

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Booking res = await BookingClient.find(widget.id);
      setState(() {
        isLoading = false;
        nameController.value = TextEditingValue(text: res.nama);
        descController.value = TextEditingValue(text: res.deskripsi);
        umurController.value = TextEditingValue(text: res.umur.toString());
        pictureController.value = TextEditingValue(text: res.picture);
      });
    } catch (err) {
      showSnackBar(
          context, err.toString(), Colors.red, const Duration(seconds: 1));
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      loadData();
    }
  }

  Widget build(BuildContext context) {
    void onSubmit() async {
      if (!_fromKey.currentState!.validate()) return;

      Booking input = Booking(
          id: widget.id ?? 0,
          nama: nameController.text,
          deskripsi: descController.text,
          umur: int.parse(umurController.text),
          picture: pictureController.text);

      try {
        if (widget.id == null) {
          await BookingClient.create(input);
        } else {
          await BookingClient.update(input);
        }

        showSnackBar(
            context, 'Success', Color(0xff15C73C), const Duration(seconds: 2));
        Navigator.pop(context);
      } catch (err) {
        showSnackBar(
            context, err.toString(), Colors.red, const Duration(seconds: 2));
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? "Tambah Booking" : "Edit Booking"),
        backgroundColor: const Color(0xff15C73C),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _fromKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.abc),
                            border: UnderlineInputBorder(),
                            labelText: 'Masukkan Nama',
                          ),
                          key: ValueKey('nama'),
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field Required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.text_fields),
                            border: UnderlineInputBorder(),
                            labelText: 'Masukkan Deskripsi',
                          ),
                          key: ValueKey('deskripsi'),
                          controller: descController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field Required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.numbers),
                            border: UnderlineInputBorder(),
                            labelText: 'Masukkan Umur',
                          ),
                          key: ValueKey('umur'),
                          controller: umurController,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            suffixIcon: Icon(Icons.local_hospital_sharp),
                            labelText: 'Masukkan Nama Dokter',
                          ),
                          key: ValueKey('dokter'),
                          controller: pictureController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field Required';
                            } else if (![
                              'arren',
                              'gush',
                              'josh',
                            ].contains(value.toLowerCase())) {
                              return 'Nama Dokter tidak tersedia, silahkan pilih dokter yang tersedia namanya adalah arren, gush, josh';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: ElevatedButton(
                          onPressed: onSubmit,
                          child: Text(
                            widget.id == null ? 'Tambah' : 'Edit',
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xff15C73C)),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
