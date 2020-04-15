import 'package:library_application_mobile/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:library_application_mobile/shared/globals.dart' as globals;

bool _loading = false;

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    globals.setPortrait();

    return _loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(globals.color6),
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            body: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 80,
                      ),
                      Container(
                        height: 100,
                        child: Center(
                            child: Image(
                          image: AssetImage("images/shallWeTalk.png"),
                          fit: BoxFit.scaleDown,
                          width: 300.0,
                        )),
                      ),
                      Container(
                        height: 20,
                      ),
                      SignUpBlock(),
                      Container(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 50,
                          right: 50,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                globals.styledRaisedButton(
                                  'Login',18.0,
                                  Color(globals.color1),
                                  Colors.white,
                                  () => widget.toggleView(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class SignUpBlock extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SignUpBlock> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController selfIntroController = new TextEditingController();
  bool _autoValidate = false;
  String _username;
  String _name;
  String _password;
  String _age;
  int _professional = -1;
  String _selectedGender;
  String _phoneno;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        height: 480,
        decoration: new BoxDecoration(
          color: Colors.amber, //(globals.color5),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: FormUI(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget FormUI() {
    return new Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: new TextFormField(
                style: globals.ts(18.0, Colors.black, FontWeight.w400),
                decoration: const InputDecoration(
                  labelText: 'Username',
                  helperText: '',
                ),
                keyboardType: TextInputType.text,
                validator: _validateUsername,
                onSaved: (String val) {
                  _username = val;
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: new TextFormField(
                style: globals.ts(18.0, Colors.black, FontWeight.w400),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  helperText: '',
                ),
                keyboardType: TextInputType.visiblePassword,
                validator: _validatePassword,
                obscureText: true,
                onSaved: (String val) {
                  _password = val;
                },
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: new TextFormField(
                style: globals.ts(18.0, Colors.black, FontWeight.w400),
                decoration: const InputDecoration(
                  labelText: 'Name',
                  helperText: '',
                ),
                keyboardType: TextInputType.text,
                validator: _validateName,
                onSaved: (String val) {
                  _name = val;
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    "Gender",
                    style: globals.ts(18.0, Colors.black, FontWeight.w400),
                  ),
                  new DropdownButton<String>(
                    items: <String>['Male', 'Female'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(
                          value,
                          style: globals.ts(18.0, Colors.black, FontWeight.w400),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      'Choose',
                      style: globals.ts(18.0, Colors.black, FontWeight.w400),
                    ), // Not necessary for Option 1
                    value: _selectedGender,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: new TextFormField(
                style: globals.ts(18.0, Colors.black, FontWeight.w400),
                decoration: const InputDecoration(
                  labelText: 'Age',
                  helperText: '',
                ),
                keyboardType: TextInputType.number,
                validator: _validateAge,
                onSaved: (String val) {
                  _age = val;
                },
              ),
            ),
            new SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: new TextFormField(
                style: globals.ts(18.0, Colors.black, FontWeight.w400),
                decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  helperText: '',
                ),
                keyboardType: TextInputType.number,
                validator: _validatePhoneNumber,
                onSaved: (String val) {
                  _phoneno = val;
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Radio(
              value: 0,
              groupValue: _professional,
              onChanged: _handleRadioValueChange,
            ),
            Text('Professional', style: globals.ts(18.0, Colors.black, FontWeight.w400)),
            SizedBox(width: 20),
            new Radio(
              value: 1,
              groupValue: _professional,
              onChanged: _handleRadioValueChange,
            ),
            Text('Normal User', style: globals.ts(18.0, Colors.black, FontWeight.w400)),
          ],
        ),
        TextField(
          controller: selfIntroController,
          style: globals.ts(18.0, Colors.black, FontWeight.w400),
          keyboardType: TextInputType.multiline,
          maxLines: 2,
          decoration: const InputDecoration(
            hintText: "Write something about yourself",
            border: OutlineInputBorder(),
            labelText: 'Self Introduction',
          ),
        ),
        new SizedBox(
          height: 10.0,
        ),
        globals.styledRaisedButton(
          'Save',18.0,
          Color(globals.color1),
          Colors.white,
          _validateInputs,
        ),
      ],
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _professional = value;
    });
  }

  String _validateUsername(String value) {
    Pattern pattern = r'(^[\w]+)$';
    RegExp regex = new RegExp(pattern);

    if (value.length < 3)
      return 'Must be more than 2 charaters';
    else if (!regex.hasMatch(value))
      return 'No space or special character';
    else
      return null;
  }

  String _validateName(String value) {
    Pattern pattern = r'(^[\w\s]+)$';
    RegExp regex = new RegExp(pattern);

    if (value.length < 3)
      return 'Must be more than 2 charaters';
    else if (!regex.hasMatch(value))
      return 'No special character';
    else
      return null;
  }

  String _validatePassword(String value) {
    if (value.length < 6)
      return 'Length cannot be less than 6';
    else
      return null;
  }

  String _validateAge(String value) {
    if (value == '' || int.parse(value) > 100 || int.parse(value) < 5)
      return 'Invalid Age';
    else
      return null;
  }

  String _validatePhoneNumber(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Enter phone number';
    } else if (!regExp.hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  void _validateInputs() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        _loading = true;
        _autoValidate = true;
      });

    }
  }
}
