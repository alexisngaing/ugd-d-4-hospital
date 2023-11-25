import 'package:flutter/material.dart';
import 'package:ugd_4_hospital/View/home.dart';
import 'package:ugd_4_hospital/database/API/UserClient.dart';
import 'package:ugd_4_hospital/database/sql_helper_profile.dart';
import 'package:ugd_4_hospital/utils/toast_util.dart';
import 'package:ugd_4_hospital/View/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
        padding: EdgeInsets.all(8.sp),
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
                          _isObscured = !_isObscured;
                        }
                      });
                    },
                    icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off,
                      size: 24.sp,
                    ),
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
              margin: EdgeInsets.all(16.sp),
              padding: EdgeInsets.all(16.sp),
              height: 350.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20.sp,
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

                          try {
                            var response =
                                await UserClient.login(email, password);
                            if (response["status"]) {
                              showToast("Login Sukses");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const HomePage()),
                              );
                            }

                            await saveEmail(email);
                          } catch (e) {
                            showToast("Login Gagal");
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 2, 168, 223),
                      ),
                      child: Text('Login'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('dont have an account?'),
                      TextButton(
                        onPressed: () {
                          Map<String, dynamic> formData = {};
                          formData['email'] = emailController.text;
                          formData['password'] = passwordController.text;
                          pushRegister(context);
                        },
                        child: Text(
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
