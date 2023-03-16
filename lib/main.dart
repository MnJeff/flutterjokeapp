import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cookie_jar/cookie_jar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Joke App',
      home: JokePage(),
    );
  }
}

class JokePage extends StatefulWidget {
  @override
  _JokePageState createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  List<String> _jokes = [
    'A child asked his father, "How were people born?" So his father said, "Adam and Eve made babies, then their babies became adults and made babies, and so on."The child then went to his mother, asked her the same question and she told him, "We were monkeys then we evolved to become like we are now."The child ran back to his father and said, "You lied to me!" His father replied, "No, your mom was talking about her side of the family."',
    'Teacher: "Kids,what does the chicken give you?" Student: "Meat!" Teacher: "Very good! Now what does the pig give you?" Student: "Bacon!" Teacher: "Great! And what does the fat cow give you?" Student: "Homework!"',
    'The teacher asked Jimmy, "Why is your cat at school today Jimmy?" Jimmy replied crying, "Because I heard my daddy tell my mommy, "I am going to eat that pussy once Jimmy leaves for school today!""',
    'A housewife, an accountant and a lawyer were asked "How much is 2+2?" The housewife replies: "Four!". The accountant says: "I think it\'s either 3 or 4. Let me run those figures through my spreadsheet one more time." The lawyer pulls the drapes, dims the lights and asks in a hushed voice, "How much do you want it to be?"',
    ""
  ];

  int _currentIndex = 0;
  bool _isFunny = false;
  CookieJar _cookieJar = CookieJar();

  Future<void> _recordVote() async {
    String cookie = 'joke_${_currentIndex.toString()}';
    List<Cookie> cookies =
        await _cookieJar.loadForRequest(Uri.parse('https://example.com'));
    bool hasCookie = cookies.any((c) => c.name == cookie);
    if (!hasCookie) {
      Cookie newCookie = Cookie(cookie, _isFunny ? 'funny' : 'not_funny');
      _cookieJar
          .saveFromResponse(Uri.parse('https://example.com'), [newCookie]);
    }
  }

  void _getNextJoke() {
    setState(() {
      _currentIndex++;
    });
    if (_currentIndex >= 4) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('That\'s all the jokes for today!'),
          content: Text('Come back another day!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String joke = _jokes[_currentIndex];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.white,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 78,
              height: 78,
            ),
            Image.asset(
              'assets/images/Leftlogo.png',
              width: 140,
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 130,
              color: Color.fromRGBO(39, 176, 96, 1),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "A joke a day keeps the doctor away",
                      style: TextStyle(fontSize: 21, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Text(
                        "If you joke the wrong way, your teeth have to pay.(Serious)",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                height: 234,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    joke,
                    style: TextStyle(
                        fontSize: 14.5, color: Color.fromARGB(255, 90, 87, 87)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 130,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero)),
                      backgroundColor: Color.fromRGBO(44, 126, 219, 1),
                    ),
                    child: Text('This is Funny'),
                    onPressed: () {
                      setState(() {
                        _isFunny = true;
                      });
                      _recordVote();
                      _getNextJoke();
                    },
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero)),
                        backgroundColor: Color.fromRGBO(39, 176, 96, 1)),
                    child: Text('This is Not Funny'),
                    onPressed: () {
                      setState(() {
                        _isFunny = false;
                      });
                      _recordVote();
                      _getNextJoke();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 23.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: Color.fromARGB(255, 169, 164, 164),
                              width: 0.3))),
                  child: Align(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SizedBox(
                        width: 350,
                        child: Text(
                            "This app is created as part of Hlsolution program. The materialscontained on this website are provided for general infomartion onlyand do not constitute any form of advice. HLS assumes no responsibility for the accuracy of any particular statement and accepts no liability for any loss or damage which may arise from reliance on the infomartion contained on this site",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 139, 137, 131)),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text("Copyright 2021 HLS")
              ],
            )
          ],
        ),
      ),
    );
  }
}
