import 'package:chat_app/base/base.dart';
import 'package:chat_app/ui/home/home_screen.dart';
import 'package:chat_app/ui/login/login_viewmodel.dart';
import 'package:chat_app/ui/registeration/register_screen.dart';
import 'package:chat_app/validation_utilis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  bool securePassword = true;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.checkedLoginUser();
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("assets/images/signin.png"),
                  fit: BoxFit.fill)),
          child: Scaffold(
            appBar: AppBar(
              title: Text("Login"),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                        Text("Welcome back!",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "please enter your E-mail Address";
                            } else if (!ValidationUtils.isValidEmail(value)) {
                              return "please enter a valid E-mail !";
                            } else {
                              return null;
                            }
                          },
                          controller: emailController,
                          decoration: const InputDecoration(
                              labelText: "E-mail Address"),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "please enter your Password";
                            } else if (value.length < 8) {
                              return "Password should be at least 8 characters";
                            } else {
                              return null;
                            }
                          },
                          controller: passController,
                          obscureText: securePassword,
                          decoration: InputDecoration(
                              labelText: "Password",
                              suffixIcon: InkWell(
                                  onTap: () {
                                    securePassword = !securePassword;
                                    setState(() {});
                                  },
                                  child: Icon(securePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off))),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            signin();
                          },
                          style: ButtonStyle(
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(12)),
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).primaryColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Login",
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              const Icon(
                                CupertinoIcons.arrow_right,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, RegisterScreen.routeName);
                            },
                            child: Text(
                              "or Create a new account ?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Theme.of(context).primaryColor),
                            ))
                      ],
                    )),
              ),
            ),
          )),
    );
  }

  var authService = FirebaseAuth.instance;

  void signin() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.login(emailController.text, passController.text);
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
