import 'package:flutter/material.dart';

class AdReg extends StatefulWidget {
  const AdReg({Key? key}) : super(key: key);

  @override
  State<AdReg> createState() => _AdRegState();
}

class _AdRegState extends State<AdReg> {
  bool passVisibiliy= true;
  final fullName = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final passWord = TextEditingController();
  final cPassWord = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ListView(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left:120,right: 120,top: 120),
                          child: Text(
                            'Welcome!',
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 90),
                        child: Text(
                          'Enter your details to register',
                          style: TextStyle(
                            fontSize: 20,
                          ),),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: TextField(
                          controller: fullName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          controller: phoneNumber,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                        child: TextField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                        child: TextField(
                          controller: passWord,
                          obscureText: passVisibiliy,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {
                                passVisibiliy = !passVisibiliy;
                              });
                            }, icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passVisibiliy
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),),
                            border: const OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                        child: TextField(
                          controller: cPassWord,
                          obscureText: passVisibiliy,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {
                                passVisibiliy = !passVisibiliy;
                              });
                            }, icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passVisibiliy
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),),

                            border: const OutlineInputBorder(),
                            labelText: 'Confirm Password',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30,left: 120,right: 120),
                        child: Container(
                          height: 50,
                          child: InkWell(
                            onTap: (){
                              if(fullName.text!='' && phoneNumber.text!='' &&
                                  email.text!='' && passWord.text!='' && cPassWord.text!='' &&
                                  passWord.text.length<=8 && (cPassWord.text==passWord.text))
                              {

                              }
                              else{
                                fullName.text==""?ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('enter your full name'),
                                    )
                                ):
                                phoneNumber.text==""?ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('enter your phonenumber'),
                                    )
                                ):
                                email.text==""?ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('enter your email'),
                                    )
                                ):
                                passWord.text==""?ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('enter password'),
                                    )
                                ):
                                cPassWord.text==""?ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('enter confirm password'),
                                    )
                                ):
                                passWord.text.length<=8?ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('password too short!'),
                                    )
                                ):
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('entered wrong password'),
                                    )
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration( color: Colors.blue.shade900,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.all(Radius.circular(8)) ),
                              child: const Center(
                                  child: Text(
                                    'Continue',
                                    style: TextStyle(color: Colors.white,fontSize: 17,) ,)),),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
