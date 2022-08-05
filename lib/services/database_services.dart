
import 'package:afmnewclareapp/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool firebaseResults ;

class DatabaseServices {
/*
  final CollectionReference videosCollection = Firestore.instance.collection(
      'videos');
  final CollectionReference ministryCollection = Firestore.instance.collection(
      'ministries');
  final CollectionReference prayerRequestCollection = Firestore.instance.collection(
      'prayerRequest');
  final CollectionReference suggestioCollection = Firestore.instance.collection(
      'suggestions');
  final CollectionReference announcementsCollection = Firestore.instance.collection(
      'announcements');
  final CollectionReference calenderCollection = Firestore.instance.collection(
      'calender');

  Future uploadVideo(String videoULR ,String videoName, ) async
  {
    String today =  DateTime.now().year.toString() + DateTime.now().month.toString() + DateTime.now().day.toString() + " " + DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString();

    return await videosCollection.document(today).setData({
      'date' : today,
      'videoULR' : videoULR,
      'videoName' : videoName,
    });
  }

  Future uploadMinistries(String ministryName ,String ministryDesc, String leaderName1 ,String leaderCell1,String leaderName2 ,String leaderCell2,) async
  {
    return await ministryCollection.document(ministryName).setData({
      'ministryName' : ministryName,
      'ministryDesc' : ministryDesc,
      'leaderName1' : leaderName1,
      'leaderCell1' : leaderCell1,
      'leaderName2' : leaderName2,
      'leaderCell2' : leaderCell2,
    });
  }

  Future addPrayerReq(String name, String prayerRequest ) async
  {
    String today =   DateTime.now().year.toString() +"-"+ DateTime.now().month.toString() + "-"+DateTime.now().day.toString() + "   " + DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString() + ":" + DateTime.now().second.toString();
    return await prayerRequestCollection.document(today).setData({
      'date' : today,
      'name' : name,
      'prayerRequest' : prayerRequest,
    });
  }

  Future addSuggestions(String suggestion ) async
  {
    String today =  DateTime.now().year.toString() + DateTime.now().month.toString() + DateTime.now().day.toString() + " " + DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString();
    return await suggestioCollection.document(today).setData({
      'date' : today,
      'suggestion' : suggestion,
    });
  }

  Future addAnnouncements(String title, String message ) async
  {
    try{
      firebaseResults = true;
    String today =  DateTime.now().year.toString() +"-"+ DateTime.now().month.toString() + "-"+DateTime.now().day.toString() + "   " + DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString() + ":" + DateTime.now().second.toString();
    return await announcementsCollection.document(today).setData({
      'date' : today,
      'title' : title,
      'message' : message,

    });

    }
    catch(e){
      firebaseResults = false;
     // firebaseError = e.toString();
      return false;
    }
  }
*/

  final CollectionReference userCollection = Firestore.instance.collection(
      'users');
  Future uploadUser(String fullnames ,String email, ) async
  {
    return await userCollection.document(email).setData({
      'fullname' : fullnames,
      'email' : email,
    });
  }
  final CollectionReference ticketCollection = Firestore.instance.collection(
      'tickets');
  Future uploadTickets(String eventNames ,String location,String date, String time, String price, String numTicket) async
  {
    return await ticketCollection.document(eventNames).setData({
      'eventname' : eventNames,
      'location' : location,
      'date' : date,
      'time' : time,
      'price' : price,
      'numTicket': numTicket
    });
  }

  final CollectionReference saleCollection = Firestore.instance.collection(
      'sales');
  Future uploadSales(String email,String eventNames ,String location,String date, String time, String price, String used,numTicket) async
  {
      return await saleCollection.document(eventNames + email).setData({
        'email' : email,
        'eventname' : eventNames,
        'location' : location,
        'date' : date,
        'numTicket' : numTicket,
        'time' : time,
        'price' : price,
        'used' : used,
      });
    }

  }




