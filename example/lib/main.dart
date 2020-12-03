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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            primaryColor: Color(0xff1890ff),
            greeting: "Welcome to the test app!",
            //newMessagePlaceholder: "Papercups",
            subtitle: "How can we help you?",
            showAgentAvailability: true,
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
    );
  }
}
