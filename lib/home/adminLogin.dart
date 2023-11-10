import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdLog extends StatefulWidget {
  const AdLog({Key? key}) : super(key: key);

  @override
  State<AdLog> createState() => _AdLogState();
}

class _AdLogState extends State<AdLog> {
  bool _passwordVisible = false;
  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(120),
                  child: Text(
                    'Admin Login',
                    style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: userName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'username',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    obscureText: _passwordVisible,
                    controller: passWord,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30, left: 120, right: 120),
                  child: Container(
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        if (userName.text != "" &&
                            passWord.text != "" &&
                            passWord.text.length >= 8) {
                        } else {
                          userName.text == ""
                              ? ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                  content: Text('enter username'),
                                ))
                              : passWord.text == ""
                                  ? ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Text('enter password'),
                                    ))
                                  : ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Text('password is too short'),
                                    ));
                        }
                      },
                      child: InkWell(
                        onTap: (){
                          FirebaseFirestore.instance.collection('admin').add({
                            'username' : userName.text,
                            'passwrod':passWord.text
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              border: Border.all(),
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          child: Center(
                              child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
