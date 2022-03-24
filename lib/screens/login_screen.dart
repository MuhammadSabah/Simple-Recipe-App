import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class LoginScreen extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.loginPath,
      key: ValueKey(AppPages.loginPath),
      child: LoginScreen(),
    );
  }

  final String? username;

  LoginScreen({
    Key? key,
    this.username,
  }) : super(key: key);

  final Color rwColor = Colors.grey.shade900;
  final TextStyle focusedStyle = const TextStyle(color: Colors.green);
  final TextStyle unfocusedStyle = const TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 280,
                  child: Image(
                    image: AssetImage('assets/app_assets/vector1-login.jpg'),
                  ),
                ),
                const SizedBox(height: 16),
                buildTextfield(username ?? 'Username', false),
                const SizedBox(height: 16),
                buildTextfield('Password', true),
                const SizedBox(height: 16),
                buildButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return SizedBox(
      height: 55,
      child: MaterialButton(
        color: rwColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          Provider.of<AppStateManager>(context, listen: false)
              .login('mockUsername', 'mockPassword');
        },
      ),
    );
  }

  Widget buildTextfield(String hintText, bool isPass) {
    return TextField(
      obscureText: isPass,
      autocorrect: false,
      autofocus: false,
      cursorColor: rwColor,
      decoration: InputDecoration(
        suffixIcon: isPass
            ? Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.green),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(height: 0.5),
      ),
    );
  }
}
