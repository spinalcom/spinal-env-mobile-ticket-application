import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qrcode_reader/qrcode_reader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.indigo),
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  _onLogin() {
    setState(() {
      _email = Text(_emailInputController.text).data;
      _password = Text(_passwordInputController.text).data;
    });
    var url = "http://10.1.23.20:3333/login";

    http.post(url, body: {"email": _email, "password": _password}).then(
        (response) {
      var js = json.decode(response.body);
      if (js['id'] != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
                  name: js['name'],
                  email: js['email'],
                  password: js['password'],
                  firstname: js['firstname'],
                  id: js['id'],
                ),
          ),
        );
      }
    });
  }

  _onSingUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateUserPage()),
    );
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
                RaisedButton(onPressed: _onLogin, child: Text("Connection")),
                RaisedButton(onPressed: _onSingUp, child: Text("Inscription")),
              ]),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String name;
  final String firstname;
  final String email;
  final String password;
  final String id;

  HomePage({this.name, this.firstname, this.password, this.email, this.id})
      : super();

  @override
  _HomePageState createState() => _HomePageState(
      name: this.name,
      email: this.email,
      password: this.password,
      firstname: this.firstname,
      id: this.id);
}

class _HomePageState extends State<HomePage> {
  int _selectedId = 0;

  String _qrNodeId = "";
  String _sentence = "";
  String categoryId = "";

  String name = "";
  String firstname = "";
  String email = "";
  String password = "";
  String id = "";

  _HomePageState(
      {this.name, this.email, this.password, this.firstname, this.id});

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [
      ProfilePage(
        name: name,
        email: email,
        password: password,
        firstname: firstname,
      ),
      CategoryChose(
          categories: fetchCategories(), onTap: this.onCategorySelected),
      SentenceSelectorPage(
        defaultSentences: fetchDefaultSentence(categoryId),
        onTap: onSentenceSelected,
      ),
      TicketDeclarationPage(_qrNodeId, _sentence, categoryId, id),
      TicketHistory(
        userId: id,
      )
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
  final String _id;

  TicketDeclarationPage(
      this._nodeId, this._sentenceId, this._categoryId, this._id);

  @override
  State<StatefulWidget> createState() {
    return _TicketDeclarationPageState(
        this._nodeId, this._sentenceId, this._categoryId, this._id);
  }
}

class _TicketDeclarationPageState extends State<TicketDeclarationPage> {
  final String _nodeId;
  final String _sentence;
  final String _category;
  final String _id;

  String _message;
  final _messageController = TextEditingController();

  _TicketDeclarationPageState(
      this._nodeId, this._sentence, this._category, this._id);

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
                labelText: 'Note', labelStyle: TextStyle(color: Colors.black)),
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
    var url = "http://10.1.23.20:3000/ticket";
    http.post(url, body: {
      'ticket': jsonEncode({'name': _sentence, 'note': _message}),
      'processId': _category,
      'userId': _id,
    }).then((response) {});
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

class SentenceSelectorPage extends StatelessWidget {
  final void Function(String) onTap;
  final Future<List<DefaultSentence>> defaultSentences;

  const SentenceSelectorPage({Key key, this.onTap, this.defaultSentences})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DefaultSentence>>(
      future: defaultSentences,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return ListView(
                children: snapshot.data
                    .map(
                      (sentence) => SentenceItem(
                            sentence.name,
                            this.onTap,
                            sentence.children,
                          ),
                    )
                    .toList());
          }
          return SentenceItem('autre', this.onTap, []);
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class DefaultSentence {
  final String name;
  final children;

  DefaultSentence({this.name, this.children});
}

Future<List<DefaultSentence>> fetchDefaultSentence(String processId) async {
  List<DefaultSentence> sentences = [];
  final String url = "http://10.1.23.20:3000/sentences/$processId";
  final response = await http.get(url);
  var tmpSentences = json.decode(response.body);
  print(tmpSentences);
  for (var i = 0; i < tmpSentences.length; i++) {
    sentences.add(DefaultSentence(
        name: tmpSentences[i]['name'], children: tmpSentences[i]['children']));
  }

  sentences.add(DefaultSentence(name: 'Autre', children: []));
  return sentences;
}

class SentenceItem extends StatefulWidget {
  final String _sentence;
  final List<dynamic> children;
  final void Function(String sentence) _onTap;

  SentenceItem(this._sentence, this._onTap, this.children);

  @override
  State<StatefulWidget> createState() {
    return SentenceItemState(this._sentence, this._onTap, this.children);
  }
}

class SentenceItemState extends State<SentenceItem> {
  String _sentence;
  List<dynamic> children;
  void Function(String sentence) _onTap;
  bool opened = false;

  SentenceItemState(this._sentence, this._onTap, this.children);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            getOpenIcon(),
            Expanded(
              child: ListTile(
                title: Text(_sentence),
                onTap: () {
                  _onTap(_sentence);
                },
              ),
            )
          ],
        ),
        getChildren()
      ],
    );
  }

  getOpenIcon() {
    if (children != null && children.length > 0) {
      return IconButton(
        icon: opened
            ? Icon(Icons.keyboard_arrow_down)
            : Icon(Icons.keyboard_arrow_right),
        tooltip: 'open',
        onPressed: () {
          setState(() {
            opened = !opened;
          });
        },
      );
    }
    return Text('');
  }

  getChildren() {
    if (this.children != null && this.opened) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 0, 0, 0),
        child: Column(
            children: children
                .map((child) =>
                    SentenceItem(child['name'], _onTap, child['children']))
                .toList()),
      );
    }
    return Text('');
  }
}

Future<List<Category>> fetchCategories() async {
  List<Category> categories = [];
  final response = await http.get('http://10.1.23.20:3000/processes');

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
          if (snapshot.data.length > 0)
            return ListView(
                children: snapshot.data
                    .map((category) => CategoryItem(
                          categoryId: category.id,
                          categoryName: category.name,
                          onTap: this.onTap,
                        ))
                    .toList());
          return Text('Aucun process de ticket créé');
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

  const CategoryItem(
      {Key key,
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
  final String email;
  final String password;
  final String name;
  final String firstname;

  ProfilePage({this.email, this.password, this.name, this.firstname});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.person_outline,
          size: 400,
        ),
        Text(name),
        Text(email),
      ],
    );
  }
}

class Tickets {
  String name;
}

Future<List<String>> fetchTicketHistory(String userId) async {
  List<String> tickets = [];
  final String url = "http://10.1.23.20:3000/tickets/$userId";
  final response = await http.get(url);
  var tmpTickets = json.decode(response.body);
  print(tmpTickets);
  for (var i = 0; i < tmpTickets.length; i++) {
    tickets.add(tmpTickets[i]['name']);
  }
  return tickets;
}

class TicketHistory extends StatefulWidget {
  final String userId;

  const TicketHistory({Key key, this.userId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TicketHistory(fetchTicketHistory(this.userId));
  }
}

class _TicketHistory extends State<TicketHistory> {
  final Future<List<String>> tickets;

  _TicketHistory(this.tickets);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: tickets,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0)
            return ListView(
                children: snapshot.data.map((ticket) => Text(ticket)).toList());
          return Text('Aucun ticket declaré');
        }

        return CircularProgressIndicator();
      },
    );
  }
}

class TicketHeader extends StatelessWidget {
  final String _name;

  TicketHeader(this._name);

  @override
  Widget build(BuildContext context) {
    return Text(_name);
  }
}

class CreateUserPage extends StatefulWidget {
  CreateUserPage({Key key}) : super(key: key);

  @override
  CreateUserPageState createState() {
    return CreateUserPageState();
  }
}

class CreateUserPageState extends State<CreateUserPage> {
  final _formKey = GlobalKey<FormState>();
  String nameInputController = "";
  String firstNameInputController = "";
  String emailInputController = "";
  String passwordInputController = "";
  String passwordConfirmationInputController = "";
  final _nameInputController = TextEditingController();
  final _firstNameInputController = TextEditingController();
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  final _passwordConfirmationInputController = TextEditingController();

  _onSignUp() {
    setState(() {
      nameInputController = Text(_nameInputController.text).data;
      firstNameInputController = Text(_firstNameInputController.text).data;
      emailInputController = Text(_emailInputController.text).data;
      passwordInputController = Text(_passwordInputController.text).data;
      passwordConfirmationInputController =
          Text(_passwordConfirmationInputController.text).data;
    });
    var url = "http://10.1.23.20:3333/user";
    http.post(url, body: {
      "name": nameInputController,
      "fistname": firstNameInputController,
      "email": emailInputController,
      "password": passwordInputController
    }).then((response) {
      var js = json.decode(response.body);
      if (js['bad'] == null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      name: js['name'],
                      firstname: js['firstname'],
                      password: js['password'],
                      email: js['email'],
                      id: js['id'],
                    )));
      }
    });
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
          key: _formKey,
          autovalidate: true,
          child: ListView(children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'champ requis';
                }
              },
              decoration: InputDecoration(
                labelText: 'Nom',
                labelStyle: TextStyle(color: Colors.black),
              ),
              keyboardType: TextInputType.text,
              controller: _nameInputController,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Prénom',
                labelStyle: TextStyle(color: Colors.black),
              ),
              keyboardType: TextInputType.text,
              controller: _firstNameInputController,
            ),
            TextFormField(
              validator: (value) {
                if (!value.contains('@')) {
                  return 'E-mail non valide';
                }
                if (value.isEmpty) {
                  return 'champs requis';
                }
              },
              decoration: InputDecoration(
                labelText: 'Adresse E-mail',
                labelStyle: TextStyle(color: Colors.black),
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailInputController,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'champs requis';
                }
              },
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                labelStyle: TextStyle(color: Colors.black),
              ),
              obscureText: true,
              keyboardType: TextInputType.text,
              controller: _passwordInputController,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field is required';
                }
              },
              decoration: InputDecoration(
                labelText: 'Confirmation mot de passe',
                labelStyle: TextStyle(color: Colors.black),
              ),
              obscureText: true,
              keyboardType: TextInputType.text,
              controller: _passwordConfirmationInputController,
            ),
            RaisedButton(onPressed: _onSignUp, child: Text("Inscription")),
          ]),
        ),
      ),
    );
  }
}
