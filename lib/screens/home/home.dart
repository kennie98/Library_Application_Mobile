import 'package:flutter/material.dart';
import 'package:library_application_mobile/models/user.dart';
import 'package:library_application_mobile/models/user_info.dart';
import 'package:library_application_mobile/shared/loading.dart';
import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:provider/provider.dart';
import 'package:library_application_mobile/helper/call_no.dart';
import 'package:library_application_mobile/screens/home/book_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String flashMsg = '';
  List<String> genreList = [];
  String _selectedGenre;

  List<String> getGenreList(List<Map<String, dynamic>> bookList) {
    Set<String> genreSet = {};
    bookList.forEach((item) {
      genreSet.add(item["genre"]);
    });
    return genreSet.toList();
  }

  Widget displayBookList(String genre) {
    return Container(
      child: BookList(selectedGenre: genre),
    );
  }

  Widget bookRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        'Books',
        style: globals.ts(30.0, Colors.black, FontWeight.w500),
      ),
    ],
  );

  Widget statusRow(String s) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(s, style: globals.ts(18.0, Colors.teal, FontWeight.w400)),
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'Logged in as',
                style: globals.ts(18.0, Colors.black, FontWeight.w400),
              ),
              SizedBox(width: 10),
              globals.styledRaisedButton("Logout", 18.0, Colors.blue, Colors.white, () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget genreSelectRow(List<String> ls) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        DropdownButton<String>(
          items: ls.map((String value) {
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
          value: _selectedGenre,
          onChanged: (newValue) {
            setState(() {
              _selectedGenre = newValue;
            });
          },
        ),
        globals.styledRaisedButton("Bookmark Page", 18.0, Colors.blue, Colors.white, () {}),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    genreList = getGenreList(globals.books);
    _selectedGenre = genreList[0];  //forced to the first element
  }

  @override
  Widget build(BuildContext context) {
    // User user = Provider.of<User>(context);
    globals.setPortrait();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            /*-- header --*/
            globals.headerHpl(),
            Expanded(
              child: Column(
                /*-- body --*/
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      children: <Widget>[
                        statusRow(flashMsg),
                        bookRow,
                        genreSelectRow(genreList),
                      ],
                    ),
                  ),
                  Expanded(
                    child: displayBookList(_selectedGenre),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
