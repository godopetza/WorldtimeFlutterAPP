import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location; //location name for the UI
  late String time; // time in that location
  late String flag; // Url to asset flag icon
  late String url_; // url to api endpoint location
  late bool isDaytime; // true when day

  WorldTime({required this.location, required this.flag, required this.url_});

  Future<void> getTime() async {

    try{
      //make request
      var url = Uri.parse("http://worldtimeapi.org/api/timezone/$url_");
      var response = await http.get(url);

      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}