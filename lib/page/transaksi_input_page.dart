import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/database/sql_helper_transaksi.dart';
import 'package:ugd_4_hospital/data/transaksi.dart';
import 'package:ugd_4_hospital/View/home.dart';
import 'package:ugd_4_hospital/data/product.dart';
import 'package:ugd_4_hospital/View/PDF/pdf_view.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class TransaksiInputPage extends StatefulWidget {
  const TransaksiInputPage({
    Key? key,
    this.title,
    this.nama,
    this.deskripsi,
    this.alamat,
    this.id,
  }) : super(key: key);

  final String? title;
  final String? nama;
  final String? deskripsi;
  final String? alamat;
  final int? id;

  @override
  State<TransaksiInputPage> createState() => _TransaksiInputPageState();
}

class _TransaksiInputPageState extends State<TransaksiInputPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerDeskripsi = TextEditingController();
  TextEditingController controllerAlamat = TextEditingController();
  Key imageKey = UniqueKey();
  Uint8List? imageFile;
  final imagePicker = ImagePicker();
  String id2 = const Uuid().v1();
  List<Product> products = [
    Product("Paracetamol", 50000),
    Product("Amoxcilin", 30000),
    Product("Lasegar", 5000),
    Product("KOMIK", 10000),
    Product("OBH", 25000),
  ];
  int number = 0;
  getTotal() => products
      .fold(0.0,
          (double prev, element) => prev + (element.price * element.amount))
      .toStringAsFixed(2);

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
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
            GestureDetector(
              onTap: () {
                showPictureDialog();
              },
              child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      imageFile != null ? MemoryImage(imageFile!) : null,
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )),
            ),
            TextFormField(
              controller: controllerNama,
              validator: (value) =>
                  value == '' ? 'Nama Tidak boleh kosong' : null,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.people_alt_outlined),
                labelText: 'Nama Pemesan',
                hintText: 'Isikan Nama anda...',
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: controllerDeskripsi,
              validator: (value) =>
                  value == '' ? 'Harus Mengisi Tujuan Penggunaan Obat' : null,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.description_outlined),
                border: UnderlineInputBorder(),
                labelText: 'Deskripsi',
                hintText: 'Isikan Tujuan Penggunaan Obat anda..',
              ),
            ),
            TextFormField(
              controller: controllerAlamat,
              validator: (value) => value == '' ? 'Must not be empty' : null,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Alamat',
                  hintText: 'Masukan Alamat anda..',
                  prefixIcon: Icon(Icons.location_city_outlined)),
            ),
            const SizedBox(
              height: 48,
            ),
            buttonCreatePDF(context),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  if (widget.id != null) {
                    await editTransaksi(widget.id!);
                    loadData();
                  } else {
                    await addTransaksi();
                    loadData();
                  }
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: const Text('Save'),
            ),
            inputProduct(),
          ],
        ),
      ),
    );
  }

//input barang
  Padding inputProduct() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 180,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final currentProduct = products[index];
                return Row(
                  children: [
                    Expanded(child: Text(currentProduct.name)),
                    Expanded(
                        child: Text(
                            "Price: Rp ${currentProduct.price.toStringAsFixed(2)}")),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                setState(() => currentProduct.amount++);
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              currentProduct.amount.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                setState(() => currentProduct.amount--);
                              },
                              icon: const Icon(Icons.remove),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
              itemCount: products.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text("Total"), Text("Rp ${getTotal()}")],
          ),
        ],
      ),
    );
  }

  Container buttonCreatePDF(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: ElevatedButton(
        onPressed: () {
          if (imageFile == null ||
              controllerNama.text.isEmpty ||
              controllerDeskripsi.text.isEmpty ||
              controllerAlamat.text.isEmpty) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Warning'),
                content: const Text('Please fill in all the fields. '),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            return;
          } else {
            createPdf(controllerNama, controllerDeskripsi, controllerAlamat,
                imageFile!, id2, context, products);
            setState(() {
              const uuid = Uuid();
              id2 = uuid.v1();
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        child: const Text('Create PDF'),
      ),
    );
  }

  Future<void> addTransaksi() async {
    await SQLHelper.addTransaksi(Transaksi(
        nama: controllerNama.text,
        deskripsi: controllerDeskripsi.text,
        alamat: controllerAlamat.text,
        foto: imageFile));
  }

  Future<void> editTransaksi(int id) async {
    await SQLHelper.editTransaksi(
        id,
        Transaksi(
            nama: controllerNama.text,
            deskripsi: controllerDeskripsi.text,
            alamat: controllerAlamat.text,
            foto: imageFile));
  }

  Future<void> loadData() async {
    final transaksi = await SQLHelper.getTransaksiById(widget.id!);
    if (transaksi != null) {
      setState(() {
        controllerNama.text = transaksi.nama!;
        controllerDeskripsi.text = transaksi.deskripsi!;
        controllerAlamat.text = transaksi.alamat!;
        imageFile = transaksi.foto;
      });
    }
  }

  Future<void> showPictureDialog() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Silahkan Pilih Foto anda'),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  getCamera();
                  Navigator.of(context).pop();
                },
                child: const Text('Camera'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  getGallery();
                  Navigator.of(context).pop();
                },
                child: const Text('Gallery'),
              ),
            ],
          );
        });
  }

  getGallery() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();

      setState(() {
        imageFile = imageBytes;
        imageKey = UniqueKey();
      });
    }
  }

  getCamera() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();

      setState(() {
        imageFile = imageBytes;
        imageKey = UniqueKey();
      });
    }
  }
}
