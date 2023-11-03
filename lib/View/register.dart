import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_4_hospital/View/login.dart';
import 'package:ugd_4_hospital/database/sql_helper_profile.dart';
import 'package:intl/intl.dart';
import 'package:ugd_4_hospital/utils/toast_util.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isEmailUniqueValidator = false;

  bool _isObscure = true;

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Future<void> _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 61, 217, 46),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                height: 550,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        hintText: 'dodi',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Username Tidak Boleh Kosong';
                        }
                        if (p0.toLowerCase() == 'anjing') {
                          return 'Tidak Boleh Menggunakan kata kasar';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: '@',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!p0.contains('@')) {
                          return 'Email harus menggunakan @';
                        }
                        if (!isEmailUniqueValidator) {
                          return 'Email sudah terdaftar, gunakan email lain';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        checkEmailUniqueness(value);
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: '*****',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: _isObscure
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: _toggleObscure,
                        ),
                      ),
                      obscureText: _isObscure,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        if (value.length < 5) {
                          return 'Password minimal 5 digit';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: noTelpController,
                      decoration: const InputDecoration(
                        labelText: 'No Telp',
                        hintText: '090090',
                        prefixIcon: Icon(Icons.phone_android),
                      ),
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Nomor Telepon tidak boleh kosong!';
                        }
                        if (p0.length < 5) {
                          return 'No Telpon Minimal 5 digit';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
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
                        prefixIcon: const Icon(Icons.calendar_today),
                        labelText: 'Tanggal',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.date_range),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                dateController.text = pickedDate
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0];
                              });
                            }
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan tanggal lahir!';
                        }
                        if (bawahUmur(value)) {
                          return 'Minimal 7 Tahun!';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        checkEmailUniqueness(emailController.text);
                        if (_formKey.currentState!.validate()) {
                          await addUser();
                          _handleLogout();
                          showToast('Register Berhasil');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        } else {
                          showToast('Gagal Register');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 0, 149, 235),
                      ),
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addUser() async {
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(dateController.text));
    await SQLHelperProfile.addUser(
      usernameController.text,
      emailController.text,
      passwordController.text,
      noTelpController.text,
      formattedDate,
    );
  }

  Future<void> checkEmailUniqueness(String email) async {
    bool isUnique = await SQLHelperProfile.isEmailUnique(email);
    setState(() {
      isEmailUniqueValidator = isUnique;
    });
  }

  bool bawahUmur(String selectedDate) {
    DateTime picked;
    try {
      picked = DateFormat('yyyy-MM-dd').parse(selectedDate);
    } catch (e) {
      throw "Format salah";
    }
    if ((DateTime.now().year - picked.year) < 7) {
      return true;
    }
    return false;
  }
}
