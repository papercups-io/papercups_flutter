import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:papercups_flutter/papercups_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;

void main() {
  runApp(
    DevicePreview(
      enabled: kIsWeb && !kDebugMode,
      builder: (ctx) => MyApp(),
      availableLocales: [Locale("en", "US")],
      defaultDevice: Devices.android.samsungS20,
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Papercups Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var show = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(show ? Icons.close : Icons.chat),
          onPressed: () {
            setState(() {
              show = !show;
            });
          }),
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
            padding: const EdgeInsets.only(bottom: 70),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: show ? 1 : 0,
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
                    onStartLoading: () {
                      print("Loading");
                    },
                    onFinishLoading: () {
                      print("Finished");
                    },
                    onError: (error) {
                      print("Error happened!");
                    },
                    closeAction: () {
                      Navigator.of(context).pop();
                    },
                    props: Props(
                      accountId: "843d8a14-8cbc-43c7-9dc9-3445d427ac4e",
                      title: "Welcome!",
                      //primaryColor: Color(0xff1890ff),
                      greeting: "Welcome to the test app!",
                      //newMessagePlaceholder: "Papercups",
                      subtitle: "How can we help you?",
                      showAgentAvailability: false,
                      customer: CustomerMetadata(
                        email: "flutter-plugin@test.com",
                        externalId: "123456789876543",
                        name: "Test App",
                        otherMetadata: {
                          "app": "example",
                        },
                      ),
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
