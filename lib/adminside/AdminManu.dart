import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:afmnewclareapp/adminside/AddTicket.dart';
import 'package:afmnewclareapp/adminside/AdminTicket.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/material.dart';



bool adminLogged = false;

class AdminManu extends StatefulWidget {
  @override
  _AdminManuState createState() => _AdminManuState();
}

class _AdminManuState extends State<AdminManu> {
  final userNameContr = TextEditingController();
  final passwordContr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return adminLogged ? Scaffold(
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
                              Image.asset('images/video.gif',height: 200,),
                              Text("Online-Tickets Manu", style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),
                              SizedBox(height: 5,),

                              Card(color: Colors.teal,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(color: Colors.white,
                                    child: ListTile(trailing: Icon(Icons.arrow_forward_ios,color: Colors.teal,),
                                      onTap: (){
                                      setState(() async{
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => AdminTickets()) );

                                      });

                                      },
                                      title:  Text("Scan Barcode", style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),
                                      subtitle:  Text("Scanning a valid barcode will change its status to 'USED' ", style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold ),),
                                    ),
                                  ),
                                ),
                              ),

                              Card(color: Colors.teal,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(color: Colors.white,
                                    child: ListTile(trailing: Icon(Icons.arrow_forward_ios,color: Colors.teal,),
                                      onTap: (){  showDialog(
                                        context: context,
                                        builder: (BuildContext context)=> Dialog (
                                            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular( 7)),
                                            elevation: 3,
                                            backgroundColor: Colors.white,
                                            child: AddTicket()),
                                      );},
                                      title:  Text("Add Event ", style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),
                                      subtitle:  Text("Add a new event and ticket ", style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold ),),
                                    ),
                                  ),
                                ),
                              ),

                             /* Card(color: Colors.teal,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(color: Colors.white,
                                    child: ListTile(trailing: Icon(Icons.arrow_forward_ios,color: Colors.teal,),
                                      onTap: (){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context)=> Dialog (
                                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular( 7)),
                                              elevation: 3,
                                              backgroundColor: Colors.white,
                                              child: DeleteTicket()),
                                        );
                                      },
                                      title:  Text("Remove Event", style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),
                                      subtitle:  Text("Scanning a valid barcode will change its status to 'USED' ", style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold ),),
                                    ),
                                  ),
                                ),
                              ),*/

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
    ):
    Scaffold(
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
                              Text("Online-Tickets Admin ", style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),
                              SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: userNameContr,
                                  style: TextStyle(fontSize: 18, color: Colors.black54),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      hintText: 'UserID',
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
                                      padding: const EdgeInsets.all(15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: Colors.teal, ),),
                                      color: Colors.teal,
                                      textColor: Colors.white,
                                      child: Text("    Login    ", ),
                                      onPressed: (){
                                        setState(() {
                                          if(userNameContr.text == "ticket" && passwordContr.text =="pass123")
                                          {   adminLogged = true;}
                                          else
                                          {
                                            MessageDialog("Please check your username and password then try again...");
                                          }
                                        });

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




