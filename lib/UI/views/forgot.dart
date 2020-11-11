import 'package:flutter/material.dart';
import 'package:teukoo/UI/widgets/my_widgets/colors.dart';
import 'package:teukoo/UI/widgets/my_material.dart';

class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  TextEditingController _pwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        title: Text("New Password", style: TextStyle(color: Color(0xFFFFFFFF))),
        backgroundColor: MyColor.bottomBarcolor,
      ),
      backgroundColor: MyColor.primaryBackground,
      body: SingleChildScrollView(
        child: InkWell(
          onTap: (() => hideKeyboard()),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: forgetform(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: MyGradients(
                            startColor: MyColor.nextCamera,
                            endColor: MyColor.closeCamera,
                            radius: 26.5),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Submit",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Widget forgetform() {
    return Container(
        width: 400,
        height: 180,
        margin: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            color: MyColor.primaryElement,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(top: 10.0, left: 10.0),
                child: Text("New Password",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16.0)),
              ),
            ),
            TextField(
              controller: _pwd,
              decoration: InputDecoration(
                  hintText: "Enter a new Password ",
                  hintStyle: TextStyle(color: Color(0xFFFFFFF)),
                  fillColor: Color(0xFFFFFFFF),
                  contentPadding: EdgeInsets.only(left: 10.0),
                  border: InputBorder.none),
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 20.0,
              ),
              maxLines: 1,
              autocorrect: false,
              obscureText: true,
            ),
            Divider(color: Color(0xFF000000)),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0, left: 10.0),
                    child: Text("New Password",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFFFFFFFF), fontSize: 16.0)),
                  ),
                ),
                TextField(
                  controller: _pwd,
                  decoration: InputDecoration(
                      hintText: "Enter a new Password ",
                      hintStyle: TextStyle(color: Color(0xFFFFFFF)),
                      fillColor: Color(0xFFFFFFFF),
                      contentPadding: EdgeInsets.only(left: 10.0),
                      border: InputBorder.none),
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20.0,
                  ),
                  maxLines: 1,
                  autocorrect: false,
                  obscureText: true,
                ),
              ],
            ),
          ],
        ));
  }
}
