import 'package:afmnewclareapp/adminside/AdminTicket.dart';
import 'package:afmnewclareapp/services/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class AddTicket extends StatefulWidget {
  const AddTicket({ key}) : super(key: key);

  @override
  _AddTicketState createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  final eventNameContr = TextEditingController();
  final locationContr = TextEditingController();
  final dateContr = TextEditingController();
  final timeContr = TextEditingController();
  final priceContr = TextEditingController();
  final ticketNum = TextEditingController();
 // dateContr.text = "2020, 12, 4";
  DatabaseServices _db = DatabaseServices();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        SizedBox(height: 10,),
        Text("New Ticket Details", style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),
        ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: eventNameContr,
                style: TextStyle(fontSize: 18, color: Colors.black54),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.event_available),
                    hintText: 'Event Name',
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
                controller: locationContr,
                style: TextStyle(fontSize: 18, color: Colors.black54),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    hintText: 'Location',
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
            ),FlatButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2020, 12, 4),
                      maxTime: DateTime(2030, 6, 7), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Text(
                  'Pick the date :',
                  style: TextStyle(color: Colors.blue),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: dateContr,
                style: TextStyle(fontSize: 18, color: Colors.black54),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range),
                    hintText: 'Date (eg.20 Sept 2020)',
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
                controller: timeContr,
                style: TextStyle(fontSize: 18, color: Colors.black54),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.access_time),
                    hintText: 'Time (17:00)',
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
                controller: priceContr,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 18, color: Colors.black54),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.monetization_on),
                    hintText: 'Ticket Price',
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
                controller: ticketNum,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 18, color: Colors.black54),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.menu_open),
                    hintText: 'Total Number of Tickets',
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
                        Navigator.pop(context) ;
                      }),

                  FlatButton(
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.teal, ),),
                    color: Colors.teal,
                    textColor: Colors.white,
                    child: Text("    Add Ticket  ", ),
                    onPressed: (){
                      _db.uploadTickets(eventNameContr.text, locationContr.text, dateContr.text, timeContr.text, priceContr.text, ticketNum.text);
                      //  _db.uploadSales("jamesleeroycode@gmail.com", "TUT VS UJ", "UJ Grounds", "20 Oct 2020", "17:00", "150","Not Yet");
                      Navigator.pop(context);
                    },
                    splashColor: Colors.tealAccent,
                  ),
                ],),),

          ],
        ),
        SizedBox(height: 30,)
      ],),
    ) ;
  }
}





class DeleteTicket extends StatefulWidget {
  @override
  _DeleteTicketState createState() => _DeleteTicketState();
}

class _DeleteTicketState extends State<DeleteTicket> {
  final eventNameContr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        SizedBox(height: 10,),
        Text("Delete Ticket", style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),
        ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: eventNameContr,
                style: TextStyle(fontSize: 18, color: Colors.black54),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.event_available),
                    hintText: 'Event Name',
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
                        Navigator.pop(context) ;
                      }),

                  FlatButton(
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.teal, ),),
                    color: Colors.teal,
                    textColor: Colors.white,
                    child: Text("    Delete Ticket  ", ),
                    onPressed: (){
                      var firestore = Firestore.instance;
                      firestore.collection('tickets').document(eventNameContr.text).delete();
                      Navigator.pop(context);
                      MessageDialog(eventNameContr.text + " event has been deleted and will not be listed on the 'Tickets' list");
                    },
                    splashColor: Colors.tealAccent,
                  ),
                ],),),

          ],
        ),
        SizedBox(height: 30,)
      ],),
    ) ;
  }
}
