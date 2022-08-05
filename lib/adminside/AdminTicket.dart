import 'dart:io';
import 'dart:math';
import 'package:afmnewclareapp/services/auth_services.dart';
import 'package:afmnewclareapp/services/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:scan_preview/scan_preview.dart';
//import 'package:barcode_scan/barcode_scan.dart';
import 'package:scan_preview/scan_preview_widget.dart';
class AdminTickets extends StatefulWidget {
  @override
  _AdminTicketsState createState() => _AdminTicketsState();
}

class _AdminTicketsState extends State<AdminTickets> {
  _requestPermission() async{
    await Permission.camera.request();
  }
  @override
void initState(){
    super.initState();
    _requestPermission();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Dashboard"),),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(height: 10,),
          Text("Select Online Ticket", style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),
          StreamBuilder(
              stream: Firestore.instance.collection(
                  'tickets').snapshots(),
            builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading...'));
                }
                else {
                  return  ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                     // physics: const BouncingScrollPhysics(),
                      //children: <Widget>[
                        //AdminOneTicket(
                          //  "Chiefs VS WITS", "250", "Grant Newlands Grounds, JHB ",
                            //" 7 Sept 2020", "18:30"),

                      //],
                        itemBuilder:(ctx, i) {
                          DocumentSnapshot ds = snapshot.data
                              .documents[i];
                          return AdminOneTicket(ds["eventname"],ds["price"], ds["location"],
                              ds["date"],ds["time"]);
                        }
                    );
                }
              }
              ),
          SizedBox(height: 30,)
        ],),
      ) ,
    ) ;
  }
}

final List<Color> circleColors = [Colors.red,Colors.blue,Colors.pink,Colors.green,Colors.black,Colors.orange,Colors.purple,Colors.yellow,];
Color randomGenerator(){
  return circleColors[new Random().nextInt(7)];
}


class AdminOneTicket extends StatefulWidget {
  final String event;
  final String money;
  final String place;
  final String date;
  final String time;
  AdminOneTicket(this.event, this.money, this.place, this.date, this.time  );
  @override
  _AdminOneTicketState createState() => _AdminOneTicketState();
}

class _AdminOneTicketState extends State<AdminOneTicket> {
  String query = "";


  //final picker = ImagePicker();
  File _image;
  @override
    Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(title: Center(child: Text(widget.event,style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold )),),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              child: Text(widget.event.substring(0,1), style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold ),),
              backgroundColor: randomGenerator() ,
            ),
          ],
        ),
        isThreeLine: true,
        trailing:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("R" +  widget.money),
          ],
        ),
        subtitle: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Row(children: <Widget>[
                SizedBox(width: 5,),
                Icon(Icons.date_range),
                Text(widget.date)
              ],),
              Row(children: <Widget>[
                SizedBox(width: 5,),
                Icon(Icons.access_time),
                Text(widget.time)
              ],),
            ],
          ),
          Row(children: <Widget>[
            SizedBox(width: 5,),
            Icon(Icons.location_on),
            Text(widget.place)
          ],),
          Row(
            children: <Widget>[
              SizedBox(width: 5,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
               /*   FlatButton(
                      child: Text(' Buy Ticket ',style: TextStyle( ),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.teal, ),),
                      color: Colors.white,
                      textColor: Colors.teal,
                      padding: const EdgeInsets.all(15),
                      onPressed: ()  {
                        setState(() async{
                          final results = await Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ScanPreviewPage()) );
                          setState(() {
                            barcode =results;
                            showDialog(
                                context: context,
                                builder: (BuildContext context)=> MessageDialogBuy("Are you sure you want to proceed buying this ticket?",barcode,widget.event, widget.money, widget.place, widget.date, widget.time));
                          });

                        });
                      }),*/
                  SizedBox(width: 30,),
                  FlatButton(
                      child: Text(' Use Ticket ',style: TextStyle( ),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.teal, ),),
                      color: Colors.white,
                      textColor: Colors.teal,
                      padding: const EdgeInsets.all(15),
                      onPressed: ()  {
                        setState(() async{
                          final results = await Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ScanPreviewPage()) );
                          setState(() {
                            barcode =results;
                            showDialog(
                                context: context,
                                builder: (BuildContext context)=> ScanBarcode(results,widget.event ));
                          });
                        });
                      }),
              ],),
            ],
          ),


        ],),
        onTap: ()async{
          //final pickedFile = await picker.getImage(source: ImageSource.camera);

          setState(() async{
            /*
            final results = await Navigator.push(context, MaterialPageRoute(
                builder: (context) => ScanPreviewPage()) );
            setState(() {
              barcode =results;
              showDialog(
                  context: context,
                  builder: (BuildContext context)=> ScanBarcode());
            });
*/
          });

        },
      ),
    );
  }
}


class ScanBarcode extends StatefulWidget {
  final String email;
  final String event;
  ScanBarcode(this.email, this.event);
  @override
  _ScanBarcodeState createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  @override
  Widget build(BuildContext context) {
    return Dialog (
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular( 7)),
      elevation: 3,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
          stream: Firestore.instance.collection(
    'sales').where("email",isEqualTo: widget.email).where("eventname",isEqualTo: widget.event).snapshots(),
    builder: (context, snapshot) {
    if (!snapshot.hasData) {
    return Center(child: Column(
      children: <Widget>[
        Text('Sorry, Scan declined because user didnt pay the ticket for this event, user should buy the ticket first...'),
        FlatButton(
            child: Text('   Back   ',style: TextStyle( ),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.teal, ),),
            color: Colors.white,
            textColor: Colors.teal,
            padding: const EdgeInsets.all(15),
            onPressed: ()  {
              Navigator.pop(context);
            }),
      ],
    ));
    }
    else {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Image.asset('images/video.gif', height: 150,),
                    Text("User Details", style: TextStyle(fontSize: 20,color: Colors.teal,fontWeight: FontWeight.bold ),),
                    SizedBox(height: 5,),

                    Card(color: Colors.teal,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Card(color: Colors.white,
                          child: ListTile(
                            title:  Text("User: " + widget.email , style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),
                            leading: Icon(Icons.person,),
                          ),
                        ),
                      ),
                    ),
                    Card(color: Colors.teal,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(color: Colors.white,
                          child: ListTile(
                            title:  Text("Location: " + widget.event, style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),
                            leading: Icon(Icons.event_available,),
                          ),
                        ),
                      ),
                    ),
                    Card(color: Colors.teal,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(color: Colors.white,
                          child: ListTile(
                            title:  Text("Ticket is valid for this user, user can enter once only", style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),
                            leading: Icon(Icons.announcement,),
                          ),
                        ),
                      ),
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
                              onPressed: ()  {
                                Navigator.pop(context);
                              }),

                          FlatButton(
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.teal, ),),
                            color: Colors.teal,
                            textColor: Colors.white,
                            child: Text("    Use Ticket    ", ),
                            onPressed: (){
                              var firestore = Firestore.instance;
                              firestore.collection('sales').document(widget.event + widget.email).delete();
                              Navigator.pop(context);
                            },
                            splashColor: Colors.tealAccent,
                          ),
                        ],),),
                  ]);
            }
          }
          ),
        ),
      ),
    );
  }
}



class MessageDialog extends StatelessWidget {
  final String message;
  MessageDialog(this.message);
  @override
  Widget build(BuildContext context) {
    return Dialog (
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular( 7)),
        elevation: 3,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:   Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(message,style: TextStyle(fontWeight: FontWeight.bold),)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(height: 2,),
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
                                  child: Text("    OK,Thanks    ", ),
                                  onPressed: (){
                                    Navigator.pop(context);//
                                  },
                                  splashColor: Colors.tealAccent,
                                ),
                              ],),),

                        ],),
                    ),


                  ]),
            )));
  }
}



class MessageDialogBuy extends StatelessWidget {
  final String message;
  final String email;
  final String event;
  final String money;
  final String place;
  final String date;
  final String time;
  MessageDialogBuy(this.message,this.email,this.event, this.money, this.place, this.date, this.time);
  final DatabaseServices _db = DatabaseServices();
  @override
  Widget build(BuildContext context) {
    return Dialog (
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular( 7)),
        elevation: 3,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:   Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(email + ": "+ message,style: TextStyle(fontWeight: FontWeight.bold),)),
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
                              onPressed: ()  {
                                Navigator.pop(context);
                              }),
                          SizedBox(width: 30,),
                          FlatButton(
                              child: Text('      Buy     ',style: TextStyle( ),),
                              shape: OutlineInputBorder(borderSide:BorderSide(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.all(15),
                              textColor: Colors.blue,
                              onPressed: () async{
                              try{
                                dynamic results =_db.uploadSales(email, event, place, date, time, money,"Not Yet", '');

                                Navigator.pop(context);

                                    if(results  == false )
                                      {showDialog(
                                    context: context,
                                    builder: (BuildContext context)=> MessageDialog("Error: " + firebaseError));
                              }}
                              catch (e) {
                                MessageDialog("Error: "+ e.string);
                              }
                              },
                          ),

                        ],),
                    ),


                  ]),
            )));
  }
}


String barcode ="";

class ScanPreviewPage extends StatefulWidget {
  @override
  _ScanPreviewPageState createState() => _ScanPreviewPageState();
}

class _ScanPreviewPageState extends State<ScanPreviewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scan barcode '),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ScanPreviewWidget(
            onScanResult: (result) {
              debugPrint('scan result: $result');
              Navigator.pop(context, result);
            },
          ),
        ),
      ),
    );
  }
}