import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:typed_data';
class Admin2Tickets extends StatefulWidget {
  @override
  _Admin2TicketsState createState() => _Admin2TicketsState();
}

class _Admin2TicketsState extends State<Admin2Tickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(height: 10,),
          Text("Select Online-Ticket to delete", style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold ),),
          ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              AdminOneTicket("Chiefs VS WITS","250","Grant Newlands Grounds, JHB "," 7 Sept 2020", "18:30"),
              AdminOneTicket("Zak Abel goes LIVE","150","FNB Stadium, JHB "," 10 Sept 2020", "20:00"),
              AdminOneTicket("Joyous Celebration 25","370","The Potter's House, Dalas), JHB "," 20 Sept 2020", "15:30")
            ],
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
          ],)
        ],),
        onTap: ()async{

        },
      ),
    );
  }
}

