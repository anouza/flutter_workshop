import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_workshop/pages/tabs/tab.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _user = TextEditingController();
  final TextEditingController _passwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();
    var storage = const FlutterSecureStorage();

  doLogin() async {
    context.loaderOverlay.show();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _user.value.text,
        password: _passwd.value.text,
      );

      storage.write(key: "user", value: _user.value.text);
      pushToHome();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      context.loaderOverlay.hide();
    }
  }

  pushToHome() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TabsPage(),
        ));
    context.loaderOverlay.hide();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

readUser();
  }

  readUser() async {
    await storage.read(key: "user").then((value) => setState(() {
          if(value != null) _user.value = TextEditingValue(text: value.toString());
        }));
  }

  @override
  Widget build(BuildContext context) {
// custom button
    Widget customButton(String buttonText,
        {Color? color,
        Color? textColor,
        void Function()? onPressed,
        double? width,
        double? height}) {
      return SizedBox(
        width: width ?? double.infinity,
        height: height ?? 50,
        child: ElevatedButton(
          onPressed: onPressed ?? () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(buttonText,
              style: TextStyle(fontSize: 18, color: textColor)),
        ),
      );
    }

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
          child: SpinKitCubeGrid(
            color: Colors.blue,
            size: 50.0,
          ),
        ),
        overlayOpacity: 0.8,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                0.5,
                0.85
              ],
                  colors: [
                Color(0xFF1C89FF),
                Color(0xFF0E4582),
              ])),
          child: Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        height: 150,
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      const Text(
                        "SWG10 Leasing",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 37,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "ເພື່ອອະນາຄົດທາງການເງິນຂອງທ່ານ",
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _user,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            fillColor: Colors.white,
                            labelText: 'User ID',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please input your User ID';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _passwd,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please input your password';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) => doLogin(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: customButton("ເຂົ້າສູ່ລະບົບ", onPressed: doLogin),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 6,
                      ),
                      const Text(
                        "ແອັບນີ້ອອກແບບ ແລະ ພັດທະນາເພື່ອການສຶກສາ",
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const Text(
                        "ຂອງຫຼັກສູດປະລິນຍາໂທ ສາຂາ ຊັອບແວ, ຮຸ່ນທີ່ 10 ເທົ່ານັ້ນ",
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
