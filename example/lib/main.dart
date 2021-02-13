import 'package:flutter/material.dart';
import 'package:papercups_flutter/papercups_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Papercups Demo',
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.cyan,
      ),
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: getTheme(context),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var show = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
          ),
          shape: BoxShape.circle,
        ),
        child: InkWell(
          customBorder: CircleBorder(),
          onTap: () {
            setState(() {
              show = !show;
            });
          },
          child: Icon(
            show ? Icons.close : Icons.chat_bubble_rounded,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            "Open the chat widget!",
            style: Theme.of(context).textTheme.headline4,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(bottom: 70, top: 50),
            child: Visibility(
              visible: show,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Theme.of(context).shadowColor.withOpacity(0.2),
                    ),
                  ],
                ),
                constraints: BoxConstraints(
                  minWidth: 100,
                  maxWidth: 400,
                  minHeight: 100,
                  maxHeight: 800,
                ),
                margin: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: PaperCupsWidget(
                    closeAction: () {
                      setState(() {
                        show = !show;
                      });
                    },
                    props: Props(
                      accountId: "843d8a14-8cbc-43c7-9dc9-3445d427ac4e",
                      title: "Welcome!",
                      //primaryColor: Color(0xff1890ff),
                      primaryGradient: LinearGradient(
                        colors: [Colors.blue, Colors.lightBlueAccent],
                      ),
                      greeting: "Welcome to the test app!",
                      subtitle: "How can we help you?",
                      customer:  null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}