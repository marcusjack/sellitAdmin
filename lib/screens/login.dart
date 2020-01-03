import 'package:app_drawer/models/authmodel.dart';
import 'package:app_drawer/services/authrepo.dart';
import 'package:flutter/material.dart';
import 'package:app_drawer/utilis/constants.dart' as Constants;

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;
  Color btnColor = Constants.btnColor;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var app = Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: secColor,
      body: Form(
        key: _formKey,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(padding: EdgeInsets.only(top: 50.0),),
            InkWell(
              onTap: () {
                setState(() {});
              },
              child: Image.asset(
                'images/logo.png',
                height: 250.0,
                width: 250.0,
              ),
            ),
            _username(),
            // Container(
            //   height: 10.0,
            // ),
            _password(),
            Container(
              height: 30.0,
            ),
            _loginButton(),
          ],
        ),
      ),
    );
    return app;
  }

  Widget _username() {
    usernameController.text = 'gitswagger';
    var app = Padding(
        padding: EdgeInsets.all(15.0),
        child: TextFormField(
          controller: usernameController,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Please Enter Valid Username';
            }
          },
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
              hintText: 'Username/Matrikel Number',
              errorStyle: TextStyle(color: mainColor, fontSize: 14.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )),
        ));
    return app;
  }

  Widget _password() {
    bool _showPassword = false;
    var app = Padding(
        padding: EdgeInsets.all(15.0),
        child: TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: 'Enter Password Here',
            errorStyle: TextStyle(color: mainColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          obscureText: !_showPassword,
          style: TextStyle(color: textColor),
        ));
    return app;
  }

  Widget _loginButton() {
    var app = RaisedButton(
        color: btnColor,
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Text("Login",
            style: TextStyle(
              color: textColor,
            )),
        onPressed: () {
          debugPrint(usernameController.text);
          if (_formKey.currentState.validate()) {
            checkUser(usernameController.text, passwordController.text)
                .then((data) {
              if (data == true) {
                Navigator.of(context).pushNamed("/home");
              }
            });
          }
        });

    return app;
  }

  Future<bool> checkUser(String username, String password) async {
    AuthModel input = AuthModel(matrikel_number: username, password: password);
    bool result = await AuthServices().authUser(input);
    return result;
  }
}
