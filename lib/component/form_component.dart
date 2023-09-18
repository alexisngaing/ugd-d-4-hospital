import 'package:flutter/material.dart';

Padding inputForm(Function(String?) validasi,
    {required TextEditingController controller,
    required String hinTxt,
    required String helperTxt,
    required IconData iconData,
    bool password = false}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
    child: SizedBox(
      width: 350,
      child: TextFormField(
        validator: (value) => validasi(value),
        autofocus: true,
        controller: controller,
        obscureText: password,
        decoration: InputDecoration(
          hintText: hinTxt,
          helperText: helperTxt,
          prefixIcon: Icon(iconData),
          border: const OutlineInputBorder(),
        ),
      ),
    ),
  );
}
