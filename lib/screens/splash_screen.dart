import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_riverpod/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getName() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('nameAccount');
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // checkNameExists();
    nameExisted();

    super.initState();
  }

  void nameExisted() async {
    String? name = await getName();
    if (name != null && name.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: 50,
                    child: TextFormField(
                      controller: _nameController,
                      autofocus: false,
                      decoration: const InputDecoration(
                        hintText: "Enter your name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please input something";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      backgroundColor: Colors.blueGrey,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString(
                          'nameAccount',
                          _nameController.text,
                        );

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  LottieBuilder.asset("assets/animation.json"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
