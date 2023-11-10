import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_4_hospital/database/sql_helper_profile.dart';
import 'package:ugd_4_hospital/utils/toast_util.dart';
import 'package:ugd_4_hospital/View/home.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController noTelpController;
  bool isPasswordVisible = false;
  Key imageKey = UniqueKey();
  Uint8List? imageFile;
  final imagePicker = ImagePicker();
  @override
  void initState() {
    loadUserData();
    _reloadProfile();
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    noTelpController = TextEditingController();
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
                        imageFile != null ? MemoryImage(imageFile!) : null,
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
              SizedBox(height: 3.h),
              SizedBox(height: 3.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      loadUserData();
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

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = prefs.getString('email') ?? '';
    });
    final userData = await _getUserData();
    if (userData != null) {
      usernameController.text = userData['username'] ?? '';
      emailController.text = userData['email'] ?? '';
      passwordController.text = userData['password'] ?? '';
      noTelpController.text = userData['noTelp'] ?? '';
      imageFile = userData['foto'] ?? '';
    }
  }

  Future<Map<String, dynamic>?> _getUserData() async {
    return await SQLHelperProfile.getUserByEmail(emailController.text);
  }

  Future<void> _updateUserData() async {
    String updatedUsername = usernameController.text;
    String updatedEmail = emailController.text;
    String updatedPassword = passwordController.text;
    String updatedNoTelp = noTelpController.text;
    Uint8List? foto = imageFile;

    await SQLHelperProfile.editUserByUsername(
        updatedUsername, updatedEmail, updatedPassword, updatedNoTelp, foto!);
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
