// import 'package:html/parser.dart' show parse;
// import 'package:html/dom.dart';

// import 'package:http/http.dart' show Client;

// import 'dart:async';

// // Website parsing repository
// class ParseWebsite {
//   Client _client = Client();

//   // single instance of the html document
//   static Document document;
//   // instance of the time in seconds
//   static int timeInSeconds;

//   static final _url = "https://utopian.rocks/queue";

//   // get the html document from the utopain.rocks/queue page
//   Future<Document> getHtml() async {
//     Document htmlString;
//     await _client
//         .get(Uri.parse(_url))
//         .then((res) => res.body)
//         .then((html) => parse(html))
//         .then((html) => htmlString = html);

//     return htmlString;
//   }

//   // grab the vote power inner html
//   Future<String> getVotePower() async {
//     String votePower;

//     // only pull document once.
//     if (document == null) {
//       document = await getHtml();
//     }

//     votePower = document.getElementById('current-vp').innerHtml;

//     return votePower;
//   }

//   // Get the timer from html document
//   Future<int> getTimer(int incomingTimer) async {
//     String time;
//     int duration;

//     // only pull document once.
//     if (document == null) {
//       document = await getHtml();
//       time = document.getElementById('time').innerHtml;
//     }

//     // reduce preformance cost of calculating time for each cycle
//     if (timeInSeconds == null) {
//       // split the clock into three strings
//       List<String> clock = time.split(':');
//       // convert the strings into intergers and then into seconds
//       var hours = int.parse(clock[0]) * 60 * 60;
//       var minutes = int.parse(clock[1]) * 60;
//       var seconds = int.parse(clock[2]);

//       timeInSeconds = hours + minutes + seconds;
//     }

//     // add the hours and minutes as seconds to the seconds and then subtract the incoming timer.
//     duration = timeInSeconds - incomingTimer;
//     return duration;
//   }
// }
