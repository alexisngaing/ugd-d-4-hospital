import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Profile extends StatefulWidget {
  final String? name;
  final String? date;
  final String? email;
  final String? notelp;

  const Profile({Key? key, this.name, this.date, this.email, this.notelp})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Colors.grey.shade300,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/profile.png'),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Colors.grey.shade300,
                              ),
                              color: Colors.green),
                          child: Icon(
                            Ionicons.pencil_sharp,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: 30),
              buildTextField("Nama", "${widget.name}"),
              buildTextField("Email", "${widget.email}"),
              buildTextField("Tanggal Lahir", "${widget.date}"),
              buildTextField("No Telp", "${widget.notelp}"),
              SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("SAVE",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white,
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text("CANCEL",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.black,
                        )),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
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
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.6),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
