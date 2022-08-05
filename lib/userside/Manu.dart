import 'dart:math';
import 'package:afmnewclareapp/adminside/AdminTicket.dart';
import 'package:afmnewclareapp/main.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:afmnewclareapp/services/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
///import 'package:barcode_generator/barcode_generator.dart';
class UserManu extends StatefulWidget {
  @override
  _UserManuState createState() => _UserManuState();
}

class _UserManuState extends State<UserManu> {
  final DatabaseServices _db = DatabaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Dashboard"),),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[


          SizedBox(height: 10,),
        Text("Your Online Tickets ", style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),

          StreamBuilder(
              stream: Firestore.instance.collection(
                  'sales').where("email",isEqualTo: userEmail).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading...'));
                }
                else {
                  return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder:(ctx, i) {
                          DocumentSnapshot ds = snapshot.data
                              .documents[i];
                          return  OneTicket(ds["eventname"],ds["price"], ds["location"],
                              ds["date"],ds["time"], ds["numTicket"] ) ;
                        }
                    );
                }
              }
          ),

          SizedBox(height: 10,),
          Text("Tickets On Sale ", style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),

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
                            ds["date"],ds["time"], ds["numTicket"],userEmail) ;
                      }
                  );
                }
              }
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                    child: Text('Show Me My Barcode To Use My Tickets',style: TextStyle( ),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.teal, ),),
                    color: Colors.white,
                    textColor: Colors.teal,
                    padding: const EdgeInsets.all(15),
                    onPressed: ()  {
                      showDialog(
                          context: context,
                          builder: (BuildContext context)=> ShowBarcode());
                    }),

              ],),),
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
  final String userEmail;
  final String date;
  final String time;
  final String numTicket;
  AdminOneTicket(this.event, this.money, this.place, this.date, this.time, this.numTicket, this.userEmail );
  @override
  _AdminOneTicketState createState() => _AdminOneTicketState();
}

class _AdminOneTicketState extends State<AdminOneTicket> {
  String query = "";

  final ticketNum = TextEditingController();
  //final picker = ImagePicker();
  final DatabaseServices _db = DatabaseServices();
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
          Row(
            children: <Widget>[
              Row(children: <Widget>[
                Icon(Icons.format_list_numbered_rounded),
                Text("Number of tickets Left:"),
                Text(widget.numTicket)
              ],),

            ],
          ),
          Row(children: <Widget>[
            SizedBox(width: 5,),
            Icon(Icons.location_on),
            Text(widget.place)
          ],),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: ticketNum,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 12, color: Colors.black54),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.list_outlined),
                  hintText: 'Number Of Tickets',
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
          Row(
            children: <Widget>[
              SizedBox(width: 5,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      child: Text(' Buy Ticket ',style: TextStyle( ),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.teal, ),),
                      color: Colors.white,
                      textColor: Colors.teal,
                      padding: const EdgeInsets.all(15),
                      onPressed: ()  {
                        setState(() async{
                          int numTicketBought = int.parse(ticketNum.text);
                          if (numTicketBought <= int.parse(widget.numTicket) ){
                        /*  Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ShowBarcode()) ); */
                          try{
                           CollectionReference saleCollection = Firestore.instance.collection(
                                'sales');
                           int totMoney = int.parse(widget.money) * int.parse(ticketNum.text);
                            await saleCollection.document(widget.event + widget.userEmail).setData({
                              'email' : widget.userEmail,
                              'eventname' : widget.event,
                              'location' : widget.place,
                              'date' : widget.date,
                              'numTicket' : ticketNum.text,
                              'time' : widget.time,
                              'price' : totMoney.toString(),
                              'used' : "Not Yet",
                            });
                           int ticketsLeft = int.parse(widget.numTicket) - numTicketBought;
                           CollectionReference ticketCollection = Firestore.instance.collection(
                               'tickets');
                           await ticketCollection.document(widget.event).updateData({

                             'numTicket': ticketsLeft.toString()
                           });

                           if(ticketsLeft==0){

                             ticketCollection.document(widget.event).delete();
                           }

                            showDialog(
                                context: context,
                                builder: (BuildContext context)=> MessageDialog("Thank for buying the tickets."));

                          }
                          catch (e) {
                            MessageDialog("Error: "+ e.string);
                           }
                          }else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context)=> MessageDialog("Sorry the ticket left is not enough for you please reduce the number and try again."));
                          }

                        });
                      }),
                  SizedBox(width: 30,),

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



class OneTicket extends StatefulWidget {
  final String event;
  final String money;
  final String place;
  final String date;
  final String time;
  final String numTicket;
  OneTicket(this.event, this.money, this.place, this.date, this.time, this.numTicket  );
  @override
  _OneTicketState createState() => _OneTicketState();
}

class _OneTicketState extends State<OneTicket> {
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

        subtitle: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Row(children: <Widget>[
                SizedBox(width: 5,),
                Icon(Icons.list),
                Text('Tickets Bought: '+ widget.numTicket)
              ],),

            ],
          ),
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
          Row(
            children: <Widget>[
              Row(children: <Widget>[
                SizedBox(width: 5,),
                Icon(Icons.monetization_on),
                Text("Total Tickets Cost: R" +  widget.money),
              ],),

            ],
          ),
          Row(children: <Widget>[
            SizedBox(width: 5,),
            Icon(Icons.location_on),
            Text(widget.place)
          ],)
        ],),
      ),
    );
  }
}


class ShowBarcode extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(child: Column (
      children: <Widget> [
        SizedBox(height: 30,),
        Card(elevation: 5,
            child: /*BarcodeGenerator(
              backgroundColor: Colors.red,
              fromString: "5665446a",
              codeType: BarCodeType.kBarcodeFormatDataMatrix,
            ), */
            Padding(
              padding: const EdgeInsets.all(1),
              child: ///BarCodeImage(params: EAN13BarCodeParams("1234567898765",barHeight: 150,),
              ///),
              ///
              QrImage(
                data: userEmail,
                version: QrVersions.auto,
                size: 350,
                gapless: false,
              ),
            )
        ),
      ],
    ),);
  }
}

