import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

void main() => runApp(const MyApp());
//----------------------Inici de sessio (log in)--------------------------------
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barber_shop',
      home: Scaffold(
        /*appBar: AppBar(title: const Text(_title)),*/
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/logo.png'),
                ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(0),
                child: const Text(
                  '',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),

            Container(
                height: 60,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    print(phoneController.text);
                    print(passwordController.text);
                  },
                )
            ),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => setup()),
                      );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Row(
              children: <Widget>[
                const Text('Also'),
                TextButton(
                  child: const Text(
                    'Log in without account',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => home()),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}

//--------------------------Registre (set up)-----------------------------------

class setup extends StatelessWidget {
  const setup({Key? key}) : super(key: key);

  static const String _title = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        /*appBar: AppBar(title: const Text(_title)),*/
        body: const Registre(),
      ),
    );
  }
}

class Registre extends StatefulWidget {
  const Registre({Key? key}) : super(key: key);

  @override
  State<Registre> createState() => _RegistreState();
}

class _RegistreState extends State<Registre> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  final dbHelper = DatabaseHelper.instance;


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Image.asset('assets/logo.png'),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(0),
                child: const Text(
                  '',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
                height: 60,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ElevatedButton(
                  child: const Text('Create Account'),
                  onPressed: (){
                    String PhoneNumber = phoneController.text;
                    String Name = nameController.text;
                    String Password = passwordController.text;
                    _insert(PhoneNumber, Name, Password);
                  }
                )
            ),
            Container(
                height: 60,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ElevatedButton(
                    child: const Text('QUERY'),
                    onPressed: _query

                )
            ),
          ],
        ));
  }


  void _insert(Phone, Name, Password) async {
    // row to insert
    Map<String, dynamic> row = {

      DatabaseHelper.columnPhone: Phone,
      DatabaseHelper.columnName: Name,
      DatabaseHelper.columnPassword: Password,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

    void _query() async {
      final allRows = await dbHelper.queryAllRows();
      print('query all rows:');
      allRows.forEach(print);
    }

}
/*-----------------------------Without Account--------------------------------*/
class home extends StatelessWidget {
const home({Key? key}) : super(key: key);

static const String _title = '';

@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'HOME PAGE',
    home: Scaffold(
      /*appBar: AppBar(title: const Text(_title)),*/
      body: const MyStatefulWidget_home(
      ),
    ),
  );
}
}

class MyStatefulWidget_home extends StatefulWidget {
  const MyStatefulWidget_home({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget_home> createState() => _MyStatefulWidgetState_home();
}

class _MyStatefulWidgetState_home extends State<MyStatefulWidget_home> {
  TextEditingController localitatController = TextEditingController();
  TextEditingController genereController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(0),
                child: const Text(
                  '',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: localitatController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Introdueix la teva localitat',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: genereController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Introdueix el teu gènere',
                ),
              ),
            ),

            Container(
                height: 60,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ElevatedButton(
                  child: const Text('Guardar'),
                  onPressed: () {
                    print(localitatController.text);
                    print(genereController.text);
                  },
                )
            ),
            Row(
              children: <Widget>[
                TextButton(
                  child: const Text(
                    'Següent',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Perfil1()),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
/*------------------------------Menu Principal--------------------------------*/

// ----------------------- Pagina conta pers. ----------------------------------

class Perfil1 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Perfil()

    );
  }
}

class Perfil extends StatefulWidget {


  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {


  // TODO: Add text editing controllers (101)
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          children: <Widget>[
            SizedBox(height: 90.0),
            CircleAvatar(
                radius: 65.0),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text("Eduard Iglesias",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text("Home",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
            ),

            SizedBox(height: 10.0),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  child: Text('Change Phone'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Phone1()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 1.0),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  child: Text('Delete Account'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Delete1()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------- Canviar telefon. --------------------------------

class Phone1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Phone()

    );
  }
}

class Phone extends StatefulWidget {

  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final dbHelper = DatabaseHelper.instance;

  TextEditingController updateController = TextEditingController();

  // TODO: Add text editing controllers (101)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/logo.png'),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: updateController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New Phone Number',
                    ),
                  ),
                ),
                Container(
                    height: 60,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: ElevatedButton(
                        child: const Text('Change Phone'),
                      onPressed: () {
                        String Phone = updateController.text;
                        _update();
                      },
                    )
                ),
                ElevatedButton(
                    child: Text('QUERY'),
                    onPressed: _query
                )

              ],
            )));

  }
  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnPhone : 'Mary',
    };
    final rowsAffected = await dbHelper.update(row);
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach(print);
  }
}
// ----------------------- Eliminar conta --------------------------------------

class Delete1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Delete()

    );
  }
}

class Delete extends StatefulWidget {

  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  final dbHelper = DatabaseHelper.instance;

  TextEditingController deleteController = TextEditingController();


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/logo.png'),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: deleteController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                ),
              ),
              Container(
                  height: 60,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: ElevatedButton(
                      child: const Text('Delete Account'),
                      onPressed: (){
                        int ID = int.parse(deleteController.text);
                        _delete(ID);
                      }
                  )
              ),
              ElevatedButton(
                child: Text('QUERY'),
                  onPressed: _query,

              )

            ],
          )));

    }
  void _delete(ID) async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(ID);
    print('deleted $rowsDeleted row(s): row $id');
  }
  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach(print);
  }
}


