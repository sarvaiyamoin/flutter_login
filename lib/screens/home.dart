import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/screens/main_home.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isSecure = true;
  final _form = GlobalKey<FormState>();
  String email = "";
  String password = "";

  void _login() async {
    var _isValid = _form.currentState!.validate();
    if (_isValid) {
      _form.currentState!.save();
      try {
        await setData();
      } catch (error) {
        print(error);
      }
      // Get.to(MainHome());

    }
  }

  Future<void> setData() async {
    print("setData");
    final response = await http
        .post(Uri.parse("https://gym.infikey.buzz/public/api/login"), body: {
      'email': email,
      'password': password,
    });
    print(response.statusCode);
    print(response.body);

    // if(response.bod)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        key: _form,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter currect email formate";
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password),
                  hintText: 'Password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isSecure = !_isSecure;
                        });
                      },
                      icon: _isSecure
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off)),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                obscureText: _isSecure,
                validator: (value) {
                  if (value!.isEmpty || value.length < 8) {
                    return "Password must be 8 character long";
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: Text("Login"))
            ],
          ),
        )),
      ),
    );
  }
}
