import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/View/home.dart';
import 'package:ugd_4_hospital/database/sql_helper_profile.dart';
import 'package:ugd_4_hospital/utils/toast_util.dart';
import 'package:ugd_4_hospital/View/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final Map? data;

  const LoginPage({super.key, this.data});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget inputForm(
      FormFieldValidator<String>? validator, {
      bool isPassword = false,
      required TextEditingController controller,
      required String hintTxt,
      required String helperTxt,
      required IconData iconData,
    }) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          validator: validator,
          obscureText: isPassword ? _isObscured : false,
          decoration: InputDecoration(
            hintText: hintTxt,
            labelText: hintTxt,
            helperText: helperTxt,
            icon: Icon(iconData),
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        if (controller.text.isEmpty) {
                          _isObscured = !_isObscured;
                        } else {
                          if (_isObscured) {
                            _isObscured = false;
                          } else {
                            _isObscured = true;
                          }
                        }
                      });
                    },
                    icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off),
                  )
                : null,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 61, 217, 46),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              height: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "email tidak boleh kosong";
                      }
                      return null;
                    },
                    controller: emailController,
                    hintTxt: "email",
                    helperTxt: "Inputkan email yang telah didaftar",
                    iconData: Icons.person,
                  ),
                  inputForm(
                    (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "password kosong";
                      }
                      return null;
                    },
                    isPassword: true,
                    controller: passwordController,
                    hintTxt: "Password",
                    helperTxt: "Inputkan Password",
                    iconData: Icons.password,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String email = emailController.text;
                          String password = passwordController.text;

                          List<Map<String, dynamic>> user =
                              await SQLHelperProfile.getUser(email);

                          if (user.isNotEmpty &&
                              user[0]['password'] == password) {
                            showToast('Login SUkses');

                            await saveEmail(email);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HomePage()),
                            );
                          } else {
                            showToast('Gagal Login');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 2, 168, 223),
                      ),
                      child: const Text('Login'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('dont have an account?'),
                      TextButton(
                        onPressed: () {
                          Map<String, dynamic> formData = {};
                          formData['email'] = emailController.text;
                          formData['password'] = passwordController.text;
                          pushRegister(context);
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 182, 202)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void pushRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterView()),
    );
  }

  Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }
}
