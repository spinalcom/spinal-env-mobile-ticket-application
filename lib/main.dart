import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:qrcode_reader/qrcode_reader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.indigo),
      home: new LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  _onLogin() {
    setState(() {
      _email = Text(_emailInputController.text).toString();
      _password = Text(_passwordInputController.text).toString();
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(40.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xff2d3d93), const Color(0xff365bab)]),
            image: DecorationImage(
              image: ExactAssetImage('images/logo.png'),
            )),
        child: Form(
          autovalidate: true,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Addresse E-mail',
                      labelStyle: TextStyle(color: Colors.white)),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailInputController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      labelStyle: TextStyle(color: Colors.white)),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  controller: _passwordInputController,
                ),
                RaisedButton(onPressed: _onLogin, child: Text("Connection"))
              ]),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _qrNodeId = "";
  int _selectedId = 0;
  String _sentence = "";
  String categoryId = "";

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [
      ProfilePage("Admin@admin.fr", "Password"),
      CategoryChose(
          categories: fetchCategories(), onTap: this.onCategorySelected),
      SentenceSelector(defaultSentences: fetchDefaultSentence(categoryId),
        onTap: onSentenceSelected,),
      TicketDeclarationPage(_qrNodeId, _sentence, categoryId),
      TicketHistory()
    ];

    return Scaffold(
        appBar: AppBar(title: Text('Location')),
        body: Center(
          child: _widgets[_selectedId],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            onPressed: _scan,
            tooltip: 'Increment',
            child: Icon(Icons.photo_camera, color: Color(0xfff68204))),
        bottomNavigationBar: BottomNavBar(onSelectedItem));
  }

  _scan() {
    Future<String> futureString = new QRCodeReader()
        .setAutoFocusIntervalInMs(200)
        .setForceAutoFocus(true)
        .setTorchEnabled(true)
        .setHandlePermissions(true)
        .setExecuteAfterPermissionGranted(true)
        .scan();
    futureString.then(_onQrScan);
  }

  _onQrScan(id) {
    setState(() {
      _qrNodeId = id;
      _selectedId = 1;
    });
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(_qrNodeId.toString()),
          );
        });
  }

  onSelectedItem(index) {
    setState(() {
      _selectedId = index;
    });
  }

  onCategorySelected(String categoryName) {
    if (categoryName.isNotEmpty) {
      setState(() {
        categoryId = categoryName;
        _selectedId = _selectedId + 1;
      });
    }
  }

  onSentenceSelected(String sentence) {
    if (sentence.isNotEmpty) {
      setState(() {
        _sentence = sentence;
        _selectedId = _selectedId + 1;
      });
    }
  }
}

class BottomNavBarState extends State<BottomNavBar> {
  void Function(int _selectedItem) _onSelectedItem;

  BottomNavBarState(this._onSelectedItem);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color(0xff365bab),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: IconButton(
                icon: Icon(IconData(0xe55a, fontFamily: 'MaterialIcons'),
                    color: Color(0xfff68204)),
                onPressed: () {
                  _onSelectedItem(0);
                },
                tooltip: 'Profile',
              )),
          Expanded(
              child: IconButton(
                icon: Icon(IconData(0xe889, fontFamily: 'MaterialIcons'),
                    color: Color(0xfff68204)),
                onPressed: () {
                  _onSelectedItem(4);
                },
                tooltip: 'Mes Tickets',
              )),
        ],
      ),
      shape: CircularNotchedRectangle(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  final void Function(int _selectedItem) _onSelectedItem;

  BottomNavBar(this._onSelectedItem);

  @override
  State<StatefulWidget> createState() {
    return BottomNavBarState(_onSelectedItem);
  }
}

class TicketDeclarationPage extends StatefulWidget {
  final String _nodeId;
  final String _sentenceId;
  final String _categoryId;

  TicketDeclarationPage(this._nodeId, this._sentenceId, this._categoryId);

  @override
  State<StatefulWidget> createState() {
    return _TicketDeclarationPageState(
        this._nodeId, this._sentenceId, this._categoryId);
  }
}

class _TicketDeclarationPageState extends State<TicketDeclarationPage> {
  final String _nodeId;
  final String _sentence;
  final String _category;
  String _message;
  final _messageController = TextEditingController();

  _TicketDeclarationPageState(this._nodeId, this._sentence, this._category);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_category),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_sentence),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
                labelText: 'Note',
                labelStyle: TextStyle(color: Colors.black)),
            keyboardType: TextInputType.text,
            controller: _messageController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(onPressed: this._onSend, child: Text("Envoyer")),
        )
      ],
    );
  }

  _onSend() {
    setState(() {
      _message = _messageController.text;
    });
    var url = "http://192.168.1.36:3000/ticket";
    http.post(url, body: {'ticket': jsonEncode({'name': _sentence, 'note': _message}) , 'processId': _category})
    .then((response){
      print(response.body);
      print('ds');
    });
  }
}

class TicketDeclarationChoose extends StatelessWidget {
  final List<Widget> _ticketTypes;

  TicketDeclarationChoose(this._ticketTypes);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(32),
      padding: EdgeInsets.all(12),
      alignment: Alignment.center,
      child: ListView(
        children: _ticketTypes,
      ),
    );
  }
}

class SentenceSelector extends StatelessWidget {
  final void Function(String) onTap;
  final Future<List<DefaultSentence>> defaultSentences;

  const SentenceSelector({Key key, this.onTap, this.defaultSentences})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DefaultSentence>>(
      future: defaultSentences,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
              children: snapshot.data
                  .map((sentence) => SentenceItem(sentence.name, this.onTap))
                  .toList());
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class DefaultSentence {
  final String name;

  DefaultSentence({this.name});
}

Future<List<DefaultSentence>> fetchDefaultSentence(String processId) async {
  List<DefaultSentence> sentences = [];
  final String url = "http://192.168.1.36:3000/sentences/$processId";
  final response = await http.get(url);
  var tmpSentences = json.decode(response.body);
  for (var i = 0; i < tmpSentences.length; i++) {
    sentences.add(DefaultSentence(name: tmpSentences[i]));
  }
  return sentences;
}

class SentenceItem extends StatelessWidget {
  final String _sentence;
  final void Function(String sentence) _onTap;

  SentenceItem(this._sentence, this._onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_sentence),
      onTap: () {
        _onTap(_sentence);
      },
    );
  }
}

Future<List<Category>> fetchCategories() async {
  List<Category> categories = [];
  final response = await http.get('http://192.168.1.36:3000/processes');

  var tmpCat = json.decode(response.body);
  for (var i = 0; i < tmpCat.length; i++) {
    categories.add(Category.fromJson(tmpCat[i]));
  }
  return categories;
}

class CategoryChose extends StatelessWidget {
  final Future<List<Category>> categories;
  final void Function(String categoryName) onTap;

  const CategoryChose({Key key, this.categories, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: categories,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data
                .map((category) =>
                CategoryItem(
                  categoryId: category.id,
                  categoryName: category.name,
                  onTap: this.onTap,
                ))
                .toList(),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}

class Category {
  final String name;
  final String icon;
  final String id;

  Category({this.name, this.icon, this.id});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name'], icon: json['icon'], id: json['id']);
  }
}

class CategoryItem extends StatelessWidget {
  final String categoryName;
  final Icon categoryIcon;
  final String categoryId;
  final void Function(String _categoryName) onTap;

  const CategoryItem({Key key,
    this.categoryName,
    this.categoryIcon,
    this.categoryId,
    this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(categoryName),
      leading: categoryIcon,
      onTap: () {
        onTap(categoryId);
      },
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String _email;
  final String _password;

  ProfilePage(this._email, this._password);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.person_outline,
          size: 400,
        ),
        Text(_email),
        Text(_password),
      ],
    );
  }
}

class TicketHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TicketHistory();
  }
}

class _TicketHistory extends State<TicketHistory> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(4, (index) {
        return TicketHeader("$index");
      }),
    );
  }
}

class TicketHeader extends StatelessWidget {
  final String _name;

  TicketHeader(this._name);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(_name);
  }
}
