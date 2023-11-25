import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_4_hospital/data/User.dart';
import 'package:ugd_4_hospital/database/API/UserClient.dart';
import 'package:ugd_4_hospital/database/sql_helper_profile.dart';
import 'package:ugd_4_hospital/main.dart';
import 'package:ugd_4_hospital/utils/toast_util.dart';
import 'package:ugd_4_hospital/View/home.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController noTelpController;
  late TextEditingController dateController;
  int? idUser;
  String? email;
  bool isPasswordVisible = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  Key imageKey = UniqueKey();
  Uint8List? imageFile;
  final imagePicker = ImagePicker();
  @override
  void initState() {
    _reloadProfile();
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    noTelpController = TextEditingController();
    dateController = TextEditingController();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  showPictureDialog();
                },
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        // imageFile != null ? MemoryImage(imageFile!) : null,
                        const AssetImage('images/josh.jpg'),
                    child: const Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    )),
              ),
              Center(
                child: Text(
                  "Dodi FirmanSyahhhhhhh",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                enabled: false,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: isPasswordVisible ? Colors.grey : Colors.blue,
                      ),
                    )),
                obscureText: isPasswordVisible,
              ),
              TextField(
                controller: noTelpController,
                decoration: const InputDecoration(
                  labelText: 'No. Telp',
                  prefixIcon: Icon(Icons.numbers),
                ),
              ),
              TextField(
                controller: dateController,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      dateController.text =
                          pickedDate.toLocal().toString().split(' ')[0];
                    });
                  }
                },
                readOnly: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today),
                  labelText: 'Tanggal',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          dateController.text =
                              pickedDate.toLocal().toString().split(' ')[0];
                        });
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              SizedBox(height: 3.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // loadUserData(ref);
                      // if (_formKey.currentState!.validate()) return;
                      _updateUserData();
                      showToast('Berhasil Ubah Data');
                      _reloadProfile();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ),
                      );
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 15.sp,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 5.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      loadUserData();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ),
                      );
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                          fontSize: 15.sp,
                          letterSpacing: 2,
                          color: Colors.black,
                        )),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 5.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.6),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String msg, Color bg) {
    final Scaffold = ScaffoldMessenger.of(context);
    Scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: bg,
        action: SnackBarAction(
            label: 'hide', onPressed: Scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    setState(() {
      isLoading = true;
    });
    try {
      User res = await UserClient.find(email);
      setState(() {
        isLoading = false;
        usernameController.value = TextEditingValue(text: res.username);
        emailController.value = TextEditingValue(text: res.email);
        passwordController.value = TextEditingValue(text: res.password);
        noTelpController.value = TextEditingValue(text: res.noTelp);
        dateController.value = TextEditingValue(text: res.tanggal);
      });
    } catch (err) {
      showSnackBar(context, err.toString(), Colors.red);
      Navigator.pop(context);
    }
  }

  Future<void> _updateUserData() async {
    // Uint8List? foto = imageFile;
    User input = User(
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
        noTelp: noTelpController.text,
        tanggal: dateController.text
        // foto: foto != null ? base64Encode(foto) : "",
        );
    try {
      await UserClient.update(input); // update db
      // ref.read(userProvider.notifier).state = input; //update state
      showSnackBar(context, 'Success', Colors.green);
      Navigator.pop(context);
    } catch (err) {
      showSnackBar(context, err.toString(), Colors.red);
      Navigator.pop(context);
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

  Future<void> _reloadProfile() async {
    await loadUserData();
    setState(() {});
  }
}
