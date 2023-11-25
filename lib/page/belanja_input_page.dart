import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ugd_4_hospital/data/Belanja.dart';
import 'package:ugd_4_hospital/View/Pasien/pasienView.dart';
import 'package:ugd_4_hospital/database/API/BelanjaClient.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:ugd_4_hospital/data/product.dart';
import 'package:ugd_4_hospital/View/PDF/pdf_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;

class TransaksiInputPage extends StatefulWidget {
  const TransaksiInputPage({super.key, this.id});
  final int? id;

  @override
  State<TransaksiInputPage> createState() => _TransaksiInputPage();
}

class _TransaksiInputPage extends State<TransaksiInputPage> {
  final _fromKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final alamatController = TextEditingController();
  bool isLoading = false;
  String id2 = const Uuid().v1();
  Uint8List? imageFile;
  Key imageKey = UniqueKey();
  final imagePicker = ImagePicker();
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

  Future<Uint8List> _getImageBytesFromUrl(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    return response.bodyBytes;
  }

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Belanja res = await BelanjaClient.find(widget.id);
      setState(() {
        isLoading = false;
        nameController.value = TextEditingValue(text: res.nama);
        descController.value = TextEditingValue(text: res.deskripsi);
        alamatController.value = TextEditingValue(text: res.alamat);
      });
    } catch (err) {
      showSnackBar(context, err.toString(), Colors.red);
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

      Belanja input = Belanja(
          id: widget.id ?? 0,
          nama: nameController.text,
          deskripsi: descController.text,
          alamat: alamatController.text);
      try {
        if (widget.id == null) {
          await BelanjaClient.create(input);
        } else {
          await BelanjaClient.update(input);
        }
        showSnackBar(context, 'Success', Colors.green);
        Navigator.pop(context);
      } catch (err) {
        showSnackBar(context, err.toString(), Colors.red);
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? "Transaksi" : "Edit Transaksi"),
        backgroundColor: Colors.green,
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
                      GestureDetector(
                        onTap: () {
                          showPictureDialog();
                        },
                        child: CircleAvatar(
                            radius: 7.h,
                            backgroundImage: imageFile != null
                                ? MemoryImage(imageFile!)
                                : null,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                radius: 2.h,
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 2.h,
                                ),
                              ),
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.abc),
                            border: UnderlineInputBorder(),
                            labelText: 'Masukkan Nama',
                          ),
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
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            suffixIcon: Icon(Icons.local_hospital_sharp),
                            labelText: 'Masukkan Alamat Anda',
                          ),
                          controller: alamatController,
                        ),
                      ),
                      inputProduct(),
                      buttonCreatePDF(context),
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
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }

  //input barang
  Padding inputProduct() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30.h,
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
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: ElevatedButton(
        onPressed: () {
          if (imageFile == null ||
              nameController.text.isEmpty ||
              descController.text.isEmpty ||
              alamatController.text.isEmpty) {
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
            createPdf(nameController, descController, alamatController,
                imageFile!, id2, context, products);
            setState(() {
              const uuid = Uuid();
              id2 = uuid.v1();
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        child: const Text('Create PDF'),
      ),
    );
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
