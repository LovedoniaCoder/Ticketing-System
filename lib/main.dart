import 'package:afmnewclareapp/adminside/AdminManu.dart';
import 'package:afmnewclareapp/adminside/AdminTicket.dart';
import 'package:afmnewclareapp/services/auth_services.dart';
import 'package:afmnewclareapp/services/database_services.dart';
import 'package:afmnewclareapp/userside/Manu.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

String userEmail = "mazivise.jamesleeroy@gmail.com";
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
      ),
      home:AdminLogin()
    );
  }
}
class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
   final userNameContr = TextEditingController();
   final passwordContr = TextEditingController();
   final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: <Widget>[
          Column(children: <Widget>[
            Container(height: 200,
              color: Colors.teal,),
            Expanded(
              child: Container(
                color: Colors.white70,),
            ),
          ],),
          Positioned.fill(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewportConstraints){
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
                      child: Card(color: Colors.white,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.teal,width: 5 )
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: <Widget>[
                              Image.asset('images/video.gif'),
                              Text("Online-Tickets ", style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: userNameContr,
                                  style: TextStyle(fontSize: 18, color: Colors.black54),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      hintText: 'Email',
                                      contentPadding: const EdgeInsets.all(15),
                                      filled: true ,
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.black),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.black),
                                        borderRadius: BorderRadius.circular(6),
                                      )
                                  ) ,),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: passwordContr,
                                  style: TextStyle(fontSize: 18, color: Colors.black54),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      hintText: 'Password',
                                      contentPadding: const EdgeInsets.all(15),
                                      filled: true ,
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.black),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.black),
                                        borderRadius: BorderRadius.circular(6),
                                      )
                                  ) ,obscureText: true,),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    FlatButton(
                                        child: Text('   Register   ',style: TextStyle( ),),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: BorderSide(color: Colors.teal, ),),
                                        color: Colors.white,
                                        textColor: Colors.teal,
                                        padding: const EdgeInsets.all(15),
                                        onPressed: ()  {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => UserRegister()) );
                                        }),

                                    FlatButton(
                                      padding: const EdgeInsets.all(15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: Colors.teal, ),),
                                      color: Colors.teal,
                                      textColor: Colors.white,
                                      child: Text("    Login    ", ),
                                      onPressed: ()async{
                                        userEmail =  userNameContr.text;
                                        try{
                                          dynamic results = await _auth
                                              .signInWithEmailAndPassword(
                                              userNameContr.text, passwordContr.text);
                                          results?  Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => UserManu()) )
                                              :showDialog(
                                              context: context,
                                              builder: (BuildContext context)=> MessageDialog("Error: " + firebaseError));
                                        }
                                        catch (e) {
                                          MessageDialog("Error: "+ e.string);

                                        }

                                      },
                                      splashColor: Colors.tealAccent,
                                    ),
                                  ],),),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[ FlatButton(
                                      child: Text('Forgot your password???',style: TextStyle( ),),
                                      shape: OutlineInputBorder(borderSide:BorderSide(color: Colors.transparent, width: 0),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: const EdgeInsets.only(left: 8,right: 8),
                                      textColor: Colors.pink,
                                      onPressed: ()  {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => AdminManu()) );
                                        //  Navigator.pop(context);
                                        /*  showDialog(
                                                context: context,
                                                builder: (BuildContext context)=> ForgotPassword());
*/
                                      }

                                  ),
                                  ]
                              ),   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[ FlatButton(
                                      child: Text('Admin Login',style: TextStyle( ),),
                                      shape: OutlineInputBorder(borderSide:BorderSide(color: Colors.transparent, width: 0),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: const EdgeInsets.only(left: 8,right: 8),
                                      textColor: Colors.pink,
                                      onPressed: ()  {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => AdminManu()) );
                                        //Navigator.pop(context);
                                        /*  showDialog(
                                                context: context,
                                                builder: (BuildContext context)=> ForgotPassword());
*/
                                      }

                                  ),
                                  ]
                              ),
                            ],),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],),
      ),
    );
  }
}


class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final userNameContr = TextEditingController();
  final passwordContr = TextEditingController();
  final fullNameContr = TextEditingController();
  final AuthService _auth = AuthService();
  DatabaseServices _db = DatabaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: <Widget>[
          Column(children: <Widget>[
            Container(height: 200,
              color: Colors.teal,),
            Expanded(
              child: Container(
                color: Colors.white70,),
            ),
          ],),
          Positioned.fill(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewportConstraints){
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
                      child: Card(color: Colors.white,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.teal,width: 5 )
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: <Widget>[
                              Image.asset('images/video.gif'),
                              Text("Register New User", style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: fullNameContr,
                                  style: TextStyle(fontSize: 18, color: Colors.black54),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      hintText: 'Full Names',
                                      contentPadding: const EdgeInsets.all(15),
                                      filled: true ,
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.black),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.black),
                                        borderRadius: BorderRadius.circular(6),
                                      )
                                  )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: userNameContr,
                                  style: TextStyle(fontSize: 18, color: Colors.black54),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      hintText: 'Email',
                                      contentPadding: const EdgeInsets.all(15),
                                      filled: true ,
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.black),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.black),
                                        borderRadius: BorderRadius.circular(6),
                                      )
                                  ) ,),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: passwordContr,
                                  style: TextStyle(fontSize: 18, color: Colors.black54),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      hintText: 'Password',
                                      contentPadding: const EdgeInsets.all(15),
                                      filled: true ,
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.black),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.black),
                                        borderRadius: BorderRadius.circular(6),
                                      )
                                  ) ,obscureText: true,),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    FlatButton(
                                        child: Text('   Cancel   ',style: TextStyle( ),),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: BorderSide(color: Colors.teal, ),),
                                        color: Colors.white,
                                        textColor: Colors.teal,
                                        padding: const EdgeInsets.all(15),
                                        onPressed: () {
                                             Navigator.pop(context);
                                        }),

                                    FlatButton(
                                      padding: const EdgeInsets.all(15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: Colors.teal, ),),
                                      color: Colors.teal,
                                      textColor: Colors.white,
                                      child: Text("    Register    ", ),
                                      onPressed: ()async{
                                        try{
                                          dynamic results = await _auth
                                              .registerWithEmailAndPassword(
                                              userNameContr.text, passwordContr.text);
                                          if(results)
                                          {Navigator.pop(context);
                                          _db.uploadUser(fullNameContr.text, userNameContr.text);
                                          }
                                          else {
                                            showDialog(
                                                context: context,
                                                builder: (
                                                    BuildContext context) =>
                                                    MessageDialog("Error: " +
                                                        firebaseError));
                                          }
                                        }
                                        catch (e) {
                                          MessageDialog("Error: "+ e.string);

                                        }

                                      },
                                      splashColor: Colors.tealAccent,
                                    ),
                                  ],),),

                            ],),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],),
      ),
    );
  }
}

