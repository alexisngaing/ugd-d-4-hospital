import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_4_hospital/View/login.dart';
import 'package:ugd_4_hospital/component/form_component.dart';
import 'package:intl/intl.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  Future<void> _showRegistrationResultDialog(bool success) async {
    String title = success ? 'Pendaftaran Berhasil' : 'Pendaftaran Gagal';
    String message =
        success ? 'Berhasil Register!!!' : 'Register Gagal!! Harap Coba Lagi!';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences _sharedPreferences;
  List<String> registeredEmails = [];

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    registeredEmails =
        _sharedPreferences.getStringList('registered_emails') ?? [];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inputForm((p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Username tidak boleh kosong';
                }
                if (p0.toLowerCase() == 'anjing') {
                  return 'Tidak boleh menggunakan kata kasar';
                }
                return null;
              },
                  controller: usernameController,
                  hinTxt: "Username",
                  helperTxt: "Ucup Surucup",
                  iconData: Icons.person),
              inputForm(((p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Email tidak boleh kosong';
                }
                if (!p0.contains('@')) {
                  return 'Email harus menggunakan @';
                }
                if (registeredEmails.contains(p0)) {
                  return 'Email sudah terdaftar. Gunakan email lain.';
                }
                return null;
              }),
                  controller: emailController,
                  hinTxt: "Email",
                  helperTxt: "ucup@gmail.com",
                  iconData: Icons.email),
              inputForm(((p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Password tidak boleh kosong';
                }
                if (p0.length < 5) {
                  return 'Password minimal 5 digit';
                }
                return null;
              }),
                  controller: passwordController,
                  hinTxt: "Password",
                  helperTxt: "xxxxxxx",
                  iconData: Icons.password,
                  password: true),
              inputForm(((p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Nomor Telepon tidak boleh kosong';
                }
                return null;
              }),
                  controller: notelpController,
                  hinTxt: "No Telp",
                  helperTxt: "082123456789",
                  iconData: Icons.phone_android),
              Container(
                width: 370,
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    hintText: 'Tanggal Lahir',
                    helperText: 'Format: DD/MM/YYYY',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal Lahir tidak boleh kosong';
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? pickerDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                    if (pickerDate != null) {
                      dateController.text =
                          DateFormat('yyyy/MM/dd').format(pickerDate);
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('username', usernameController.text);
                    prefs.setString('email', emailController.text);
                    prefs.setString('password', passwordController.text);
                    registeredEmails.add(emailController.text);

                    bool registrationSuccessful = true;
                    _sharedPreferences.setStringList(
                        'registered_emails', registeredEmails);

                    _showRegistrationResultDialog(registrationSuccessful);

                    if (registrationSuccessful) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginPage(),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Register'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
